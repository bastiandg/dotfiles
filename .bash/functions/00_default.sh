function bak() {
	cp "$1" "$1.bak$(date "+%Y%m%d")"
}

#grep the history and show the results in less
function hgl () {
	history | grep -i "$1" | less
}

#grep for processes
function psg () {
	ps aux | grep -i "$1"
}


#make a directory and change to it
mcd () {
	mkdir "$@" && cd "${!#}"
}

# Handy Extract Program
extract() {

     if [ -f $1 ] ; then
         case $1 in
             *.tar.bz2)   tar xvjf $1     ;;
             *.tar.gz)    tar xvzf $1     ;;
             *.bz2)       bunzip2 $1      ;;
             *.rar)       unrar x $1      ;;
             *.gz)        gunzip $1       ;;
             *.tar)       tar xvf $1      ;;
             *.tbz2)      tar xvjf $1     ;;
             *.tgz)       tar xvzf $1     ;;
             *.zip)       unzip $1        ;;
             *.Z)         uncompress $1   ;;
             *.7z)        7z x $1         ;;
             *)           echo "'$1' cannot be extracted via >extract<" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}

#update all git repos
ug() {
CURRENTDIR="$(pwd)"
GITDIRECTORIES="$(ls -d "$HOME/"*git)"
MAXTHREADCOUNT=10

for GITDIRECTORY in $GITDIRECTORIES ; do
    for repo in $(ls -1 "$GITDIRECTORY/"); do
        while [ "$(jobs | wc -l)" -ge "$MAXTHREADCOUNT" ] ; do
            sleep 1
        done
        cd "$GITDIRECTORY/$repo"
        git pull &
        echo -e "\033[01;34m --- $repo pull started --- \033[00m"
    done
done
wait
cd "$CURRENTDIR"
}

# https://unix.stackexchange.com/a/4220
make-completion-wrapper () {
  local function_name="$2"
  local arg_count=$(($#-3))
  local comp_function_name="$1"
  shift 2
  local function="
    function $function_name {
      ((COMP_CWORD+=$arg_count))
      COMP_WORDS=( "$@" \${COMP_WORDS[@]:1} )
      "$comp_function_name"
      return 0
    }"
  eval "$function"
}

f () {
   find . -iname "*${1}*"
}

se () {
  grep "$1" "$HOME/.ssh/config" | cut -d " " -f 2
}


#calculate
if [ "$(which bc )" ] ; then
	calc () {
		bc -l <<< "scale=0; $*"
	}
elif [ "$(which python )" ] ; then
	calc () {
		python -c "print $*" 2> /dev/null
	}
elif [ "$(which perl )" ] ; then
	calc () {
		perl -E "say $*" 2> /dev/null
	}
else
	echo "please install either bc or perl" >&2
	calc () {
		echo "1"
	}
fi
