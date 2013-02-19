# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

#vim the one and only
export EDITOR=/usr/bin/vim
export ADMINREPO=/root/adminrepo
# colorful manpages
export GREP_OPTIONS='--color=auto'
#export GREP_COLOR='1;32'
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;36m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'
export LESS=' -iR'

#add my own scripts to the command list
if [ -d ~/script ]
then
	export PATH=~/script:"$PATH"
fi

HISTCONTROL=ignoredups
HISTFILESIZE=10000000
HISTSIZE=10000000
HISTIGNORE=" *:&:hg*:history*:ls:ll:la:lla:l:clear:bg:fg"
HISTTIMEFORMAT='%F %T '

#append to the history file, don't overwrite it
shopt -s histappend

#Write out history after each command
PROMPT_COMMAND='history -a'

#vim as manpager
export MANPAGER="/bin/sh -c \"col -b | vim -c 'set ft=man ts=8 nomod nolist nonu noma' -\""

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

#make a unique color prompt for every host
seed=$(hostname -f | md5sum | tr -dc '1234567')
hc1=${seed:1:1}
hc2=${seed:2:1}

# Prompt setup, with SCM status
parse_git_branch() {
	local DIRTY STATUS
	STATUS=$(git status 2>/dev/null)
	[ $? -eq 128 -o $? -eq 127 ] && return
	[[ "$STATUS" == *'working directory clean'* ]] || DIRTY=' *'
	echo "($(git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* //')$DIRTY)"
}

#parse_svn_revision() {
	#local DIRTY 
	#REV=$(svn info 2>/dev/null | grep Revision | sed -e 's/Revision: //')
	#echo "$(svn info \| grep Revision)" # \| sed -e 's/Revision: //')"
	#[ "$REV" ] || echo " $REV" && return "1234"
	#[ "$(svn st)" ] && DIRTY=' *'
	#echo "(r$REV$DIRTY)"
#}
parse_svn_revision() {
	local REV=$(svnversion 2>/dev/null)
	#[ -d ".svn" ] || return
	[ $? -eq 0 ] || return
	[ "$REV" == 'exportiert' ] && return
	echo " ($REV)"
	#echo "$REV" | grep : &> /dev/null
	#if [ $? == "0" ] ; then
		#echo "\\[\\033[01;32m\\]($REV)\\[\\033[00m\\]"
	#else
		#echo "REV"
	#fi
}

scm_ps1() {
	ret="$?"
    local s=
    if [ -d ".svn" ] ; then
        s=\(svn:$(svn info | sed -n -e '/^Revision: \([0-9]*\).*$/s//\1/p' )\)
    fi
    echo -n "$s"
    return $ret #save the returnvalue
}

if [ "$(whoami)" == "root" ] ; then
	ROOT="- \[\033[01;91m\]root!\[\033[00m\]"
else
	ROOT=""
fi

#I ADDED THIS TO SHORTEN PWD
_PS1 ()
{
	local PRE= NAME="$1" LENGTH="$2";
	[[ "$NAME" != "${NAME#$HOME/}" || -z "${NAME#$HOME}" ]] &&
	PRE+='~' NAME="${NAME#$HOME}" LENGTH=$[LENGTH-1];
	((${#NAME}>$LENGTH)) && NAME="/...${NAME:$[${#NAME}-LENGTH+4]}";
	echo "$PRE$NAME"
}

#Command Number
CMDNR="\!"
#User
U="\[\e[01;3${hc1}m\]\u\[\e[00m\]"
#Host
H="\[\e[01;3${hc2}m\]\h\[\e[00m\]"
#Directory
DIR="\[\033[01;34m\]\w\[\033[00m\]"
#Date
#DATE="\[\033[01;36m\]\t \d\[\033[00m\]"
DATE="\t \d"
#Current tty
TTY="\l"
#Return code
RETURN="\$(ret=\$?; if [[ \$ret = 0 ]];then echo \"\[\033[01;32m\]\$ret\";else echo \"\[\033[01;31m\]\$ret\";fi)\[\033[00m\]"


#the actual prompt with a colorised return code
#PS1="$CMDNR $U@$H:$DIR $RETURN"'$(scm_ps1)'" \$ " #schnell
#PS1="$CMDNR $U@$H:$DIR $RETURN"'$(parse_svn_revision)'" \$ " #langsam
PS1="$U@$H - $DATE - tty$TTY - $CMDNR "'$(scm_ps1) '"$ROOT \n\[\033[01;34m\]"'$(_PS1 "$PWD" 50)'"\[\033[00m\] $RETURN \$ " #schnell

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

#if [ -f ~/.bash_aliases ]; then
#    . ~/.bash_aliases
#fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls -F --color=auto'
fi

if [ -e  "$HOME/.local-aliases" ]; then
	source "$HOME/.local-aliases"
fi
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
# aliases
alias ll='ls -l'
alias la='ls -A'
alias lla='ls -lA'
alias l='ls -l'
alias cp='cp -vr'
alias mv='mv -v'
alias rm='rm -v'
alias du='du -ch'
alias clip='xclip -selection clipboard'
alias ..='cd ..'
alias ...='cd ../..'
alias hg='history | grep'
alias diff="diff -u"
alias utop='top -u "$USER"'
alias irc='screen -x irc'
alias vla='virsh list --all'
alias g='grep'
alias mkdir='mkdir -p'
alias df='df -h'
alias vim='vim -X'
alias v='vim'
alias f='find . -iname'
alias s='ssh'
alias ducks='du -cksh * | sort -rn | head -11' # Lists folders and files sizes in the current folder
alias abs='readlink -f' #shows the absolute path
alias cmus="$HOME/scripts/cmusbackup.sh && /usr/bin/cmus"
alias sx="screen -x"
alias webserver="python -m SimpleHTTPServer 8080"
alias chmox="chmod +x"

#colourise
if [ -e /usr/bin/grc ]
then
	alias grc='grc -es'
	alias ping='grc ping'
	alias traceroute='grc /usr/sbin/traceroute'
	alias netstat='grc netstat'
	alias diffc='grc diff -u'
	alias make='grc make'
	alias tail='grc tail'
	alias cat='grc cat'
	function log () {
		grc cat "$1" | less
	}
fi

#use htop instead of top
if [ -e /usr/bin/htop ]
then
	alias top='htop'
fi

function update_dotfiles() {
	if [ "$(which git)" ]; then
		if [ ! -e ~/dotfiles/ ] ; then
			git clone git@github.com:bastiandg/dotfiles.git ~/dotfiles
		else
			(cd ~/dotfiles/ && git pull)
		fi
		cp -r ~/dotfiles/.bashrc ~/.bashrc
		rm -rf ~/.vim/ ~/.vimrc
		cp -r ~/dotfiles/.vimrc ~/.vimrc
		cp -r ~/dotfiles/.vim ~/.vim
	else
		echo "git is not installed"
	fi
}

function bak() {
	cp "$1" "$1.bak$(date "+%Y%m%d")"
}

#grep the history and show the results in less
function hgl () {
	history | grep "$1" | less
}

#grep for processes
function psg () {
	ps aux | grep "$1"
}

#calculate
calc () {
	echo "$*" | bc -l
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

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# Set up ssh-agent
SSH_ENV="$HOME/.ssh/environment"

function start_agent {
    echo "Initializing new SSH agent..."
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add;
}

# Source SSH settings, if applicable
if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    #ps ${SSH_AGENT_PID} doesn't work under cywgin
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi
