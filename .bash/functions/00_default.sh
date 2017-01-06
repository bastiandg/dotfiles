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
function mcd () {
	mkdir "$@" && cd "${!#}"
}

# Handy Extract Program
function extract() {
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
function ug() {
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

function f () {
    find . -iname "*${1}*"
}

function se () {
    grep "$1" "$HOME/.ssh/config" | cut -d " " -f 2
}

function grin () {
    grep -rin --color=always "$1" *
}

#calculate
if [ "$(which bc )" ] ; then
	function calc () {
		bc -l <<< "scale=0; $*"
	}
elif [ "$(which python )" ] ; then
	function calc () {
		python -c "print $*" 2> /dev/null
	}
elif [ "$(which perl )" ] ; then
	function calc () {
		perl -E "say $*" 2> /dev/null
	}
else
	echo "please install either bc or perl" >&2
	function calc () {
		echo "1"
	}
fi
