bak() {
  cp "$1" "$1.bak$(date "+%Y%m%d")"
}

#grep the history and show the results in less
hgl () {
  history | \grep -i --color=always "$1" | less
}

#grep for processes
psg () {
  ps aux | grep -i "$1"
}


#make a directory and change to it
mcd () {
  mkdir "$@" && cd "${!#}"
}

# Handy Extract Program
extract() {
     if [[ -f "$1" ]] ; then
         case "$1" in
             *.tar.bz2)   tar xvjf "$1"     ;;
             *.tar.gz)    tar xvzf "$1"     ;;
             *.bz2)       bunzip2 "$1"      ;;
             *.rar)       unrar x "$1"      ;;
             *.gz)        gunzip "$1"       ;;
             *.tar)       tar xvf "$1"      ;;
             *.tbz2)      tar xvjf "$1"     ;;
             *.tgz)       tar xvzf "$1"     ;;
             *.zip)       unzip "$1"        ;;
             *.Z)         uncompress "$1"   ;;
             *.7z)        7z x "$1"         ;;
             *)           echo "'$1' cannot be extracted via >extract<" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
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

tp () {
  if echo "$1" | grep -q ":" ; then
    echo "$1 h $h p $p"
    h="$(echo "$1" | cut -d ":" -f 1 )"
    p="$(echo "$1" | cut -d ":" -f 2 )"
    echo "q" | telnet -eq "$h" "$p"
  else
    echo "q" | telnet -eq "$1" "$2"
  fi
}

#calculate
calc () {
  awk "BEGIN {print ($*) }"
}

if command -v gron &> /dev/null ; then
  jg () {
    if [[ "$#" -lt 1 ]]; then
      echo "$0 [pattern] data_source" >&2
      return 1
    fi
    pattern="$1"
    data_source="${2:-}" # gron autodetects whether it's a path or a url

    if [[ -z "$pattern" ]] ; then
      gron "$data_source"
    elif command -v jq &> /dev/null ; then
      gron ${data_source:+"$data_source"} | grep -- "$pattern" | gron --ungron | jq
    fi
  }
fi
