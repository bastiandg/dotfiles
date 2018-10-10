if [ "$(whoami)" == "root" ] ; then
	ROOT=" - \[\033[01;91m\]root!\[\033[00m\]"
else
	ROOT=""
fi

#SHORTEN PWD
_PS1 ()
{
	ret="$?"
	local PRE= NAME="$1" LENGTH="$2";
	[[ "$NAME" != "${NAME#$HOME/}" || -z "${NAME#$HOME}" ]] &&
	PRE+='~' NAME="${NAME#$HOME}" LENGTH=$[LENGTH-1];
	((${#NAME}>$LENGTH)) && NAME="/...${NAME:$[${#NAME}-LENGTH+4]}";
	echo "$PRE$NAME"
	return $ret #save the returnvalue
}

FQDN="$(hostname -f)"

if false which mawk &> /dev/null ; then
    AWK=mawk
else
    AWK=gawk\ --non-decimal-data
fi

COLOR_CODES="$($AWK '

function brightness (r, g, b)
{
    return int(sqrt(r * r * 0.299 + g * g * 0.587 + b * b * 0.114))
}

function lighten (n) {
    return n + (255 - n) * 0.1
}

BEGIN{
n = "'"$(sha512sum <<< "$FQDN" | cut -d" " -f1)"'"
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
H="\[\033[38;2;${COLOR_ARRAY[1]}m\]$(hostname -f)\[\033[00m\]"

#Directory
DIR="\[\033[01;34m\]"'$(_PS1 "$PWD" 50)'"\[\033[00m\]"
#Date
DATE="\e[1m\t \d\[\033[00m\]"
#Current tty
TTY="\l"
#Return code
RETURN="\$(ret=\$?; if [[ \$ret = 0 ]];then echo \"\[\033[01;32m\]✓\";else echo \"\[\033[01;31m\]\$ret\";fi)\[\033[00m\]"
#

#the actual prompt with a colorised return code
PS1="$DATE - $DIR$ROOT\n$U@$H $RETURN \$ " #schnell
