if [ "$(whoami)" == "root" ]; then
  ROOT=" - \[\033[01;91m\]root!\[\033[00m\]"
else
  ROOT=""
fi

#SHORTEN PWD
_PS1() {
  ret="$?"
  local PRE= NAME="$1" LENGTH="$2"
  [[ $NAME != "${NAME#$HOME/}" || -z ${NAME#$HOME} ]] &&
    PRE+='~' NAME="${NAME#$HOME}" LENGTH=$((LENGTH - 1))
  ((${#NAME} > LENGTH)) && NAME="/...${NAME:$((${#NAME} - LENGTH + 4))}"
  echo "$PRE$NAME"
  return $ret #save the returnvalue
}

HOSTNAME="$(timeout "0.5" hostname -f 2> /dev/null || hostname)"

if which mawk &>/dev/null; then
  AWK=mawk
else
  AWK=gawk\ --non-decimal-data
fi

__kube_ps1()
{
  ret="$?"
  # Get current context
  CONTEXT=$(grep "current-context:" ~/.kube/config | sed "s/current-context: //")
  GREEN='\033[0;32m'
  YELLOW='\033[1;33m'
  RED='\033[1;31m'
  COLOR_OFF='\033[0m'

  if [[ -z "$CONTEXT" ]]; then
    return "$ret" #save the returnvalue
  fi
  if grep -q 'prd\|prod\|live' <<< "$CONTEXT"; then
    CONTEXT_COLOR="$RED"
  elif grep -q "qua\|qa\|test" <<< "$CONTEXT"; then
    CONTEXT_COLOR="$YELLOW"
  else
    CONTEXT_COLOR="$GREEN"
  fi
  echo -e "(k8s: ${CONTEXT_COLOR}${CONTEXT}${COLOR_OFF})"
  return "$ret" #save the returnvalue
}

COLOR_CODES="$($AWK '

function brightness (r, g, b)
{
    return int(sqrt(r * r * 0.299 + g * g * 0.587 + b * b * 0.114))
}

function lighten (n) {
    return n + (255 - n) * 0.1
}

BEGIN{
n = "'"$(sha512sum <<<"$HOSTNAME" | cut -d" " -f1)"'"
position = 1
threshold = 100
while ((brightness(r1, b1, g1) < threshold || brightness(r2, b2, g2) < threshold) && position < 120) {
	r1 = lighten(int("0x" substr(n, position, 2)))
	r2 = lighten(int("0x" substr(n, position + 2, 2)))
	g1 = lighten(int("0x" substr(n, position + 4, 2)))
	g2 = lighten(int("0x" substr(n, position + 6, 2)))
	b1 = lighten(int("0x" substr(n, position + 8, 2)))
	b2 = lighten(int("0x" substr(n, position + 10, 2)))
	position = position + 2
}
printf "%i;%i;%i\n", r1, g1, b1
printf "%i;%i;%i", r2, g2, b2
}')"

COLOR_ARRAY=(${COLOR_CODES//\n/ })

#Command Number
#CMDNR="\!"
#User
U="\[\033[38;2;${COLOR_ARRAY[0]}m\]\u\[\033[00m\]"

#Host
H="\[\033[38;2;${COLOR_ARRAY[1]}m\]${HOSTNAME}\[\033[00m\]"

#Directory
DIR="\[\033[01;34m\]"'$(_PS1 "$PWD" 50)'"\[\033[00m\]"
#Date
DATE="\e[1m\t \d\[\033[00m\]"
#Current tty
TTY="\l"
#Return code
RETURN="\$(ret=\$?; if [[ \$ret = 0 ]];then echo \"\[\033[01;32m\]✓\";elif [[ \$ret = 130 ]]; then echo \"✋\"; else echo \"\[\033[01;31m\]\$ret\";fi)\[\033[00m\]"
#kubectl context
#KUBECONTEXT='$(__kube_ps1)'
KUBECONTEXT=''

export GIT_PS1_SHOWCOLORHINTS=1

#Write out history after each command
export PROMPT_COMMAND='__git_ps1 "${DATE} - ${KUBECONTEXT} ${DIR}${ROOT}" "\n${U}@${H} ${RETURN} \$ "; history -a'
