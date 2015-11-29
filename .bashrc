# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

#vim the one and only
export EDITOR=/usr/bin/vim
export CDPATH=.:~
# colorful manpages
export GREP_OPTIONS='--color=auto'
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;36m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'
export LESS=' -iR'
export NVIM_TUI_ENABLE_TRUE_COLOR='1'

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
export MANPAGER="/bin/sh -c \"col -b | vim -c 'set ft=man ts=8 nomod nolist nonu noma' -c 'map q :q<CR>' -\""

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# aliases
alias ll='ls -l'
alias la='ls -la'
alias lla='ls -la'
alias l='ls -l'
alias cp='cp -vr'
alias mv='mv -v'
alias rm='rm -v'
alias du='du -ch'
alias clip='xclip -selection clipboard'
alias ..='cd ..'
alias ...='cd ../..'
alias hg='history | grep -i -B3'
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
alias ducks='du -cksh * | sort -rh | head -11' # Lists folders and files sizes in the current folder
alias abs='readlink -f' #shows the absolute path
alias sx="screen -x"
alias webserver="python -m SimpleHTTPServer 8080"
alias cx="chmod +x"
alias mtr="mtr -t" #curses and no X for mtr
alias telnet="telnet -eq"
alias il='ip addr | grep inet | sed -e "s#\s*inet \([0-9.]*\).*\ \([a-z0-9]*\)#\2 \1#g"'

#calculate
calc () {
	if [ "$(which bc )" ] ; then
		echo "scale=0; $*" | bc -l
	elif [ "$(which perl )" ] ; then
		perl -E "say $*" 2> /dev/null
	else
		echo "please install either bc or perl" >&2
	fi
}

#colourise
if [ -e /usr/bin/grc ]
then
	alias grc='grc -es'
	alias ping='grc ping'
	alias traceroute='grc /usr/sbin/traceroute'
	alias netstat='grc netstat'
	alias diffc='grc diff -u'
	alias make='grc make'
	function log () {
		grc cat "$1" | less
	}
fi

#use htop instead of top
if [ -e /usr/bin/htop ]
then
	alias top='htop'
fi

# Prompt setup, with SCM status
parse_git_branch() {
	local DIRTY STATUS
	STATUS=$(git status 2>/dev/null)
	[ $? -eq 128 -o $? -eq 127 ] && return
	[[ "$STATUS" == *'working directory clean'* ]] || DIRTY=' *'
	echo "($(git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* //')$DIRTY)"
}

parse_svn_revision() {
	local REV=$(svnversion 2>/dev/null)
	[ $? -eq 0 ] || return
	[ "$REV" == 'exportiert' ] && return
	echo " ($REV)"
}

scm_ps1() {
	ret="$?"
	local s=
	if [ -d ".svn" ] ; then
		s=\(svn:$(svn info | sed -n -e '/^Revision: \([0-9]*\).*$/s//\1/p' )\)
	fi
	echo -n " $s"
	return $ret #save the returnvalue
}

if [ "$(whoami)" == "root" ] ; then
	ROOT="- \[\033[01;91m\]root!\[\033[00m\]"
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

lighten () {
    echo "$(LANG=C printf '%.0f' "$(calc "$1 + (255 - $1) * $2")")"
}

md5="$(hostname -f | md5sum | cut -d" " -f1)"
threshold="80"
fac="0.1"
pos="0"
r1="0" g1="0" b1="0" r2="0" g2="0" b2="0"
while [ \( \( $r1 -le $threshold -a $g1 -le $threshold -a $b1 -le $threshold \) \
    -o \( $r2 -le $threshold -a $g2 -le $threshold -a $b2 -le $threshold \) \) \
    -a $pos -lt 20 ] ; do
    r1="$((16#${md5:$pos:2}))"
    r2="$((16#${md5:$((pos + 2)):2}))"
    g1="$((16#${md5:$((pos + 4)):2}))"
    g2="$((16#${md5:$((pos + 6)):2}))"
    b1="$((16#${md5:$((pos + 8)):2}))"
    b2="$((16#${md5:$((pos + 10)):2}))"

    r1=$(lighten $r1 $fac)
    r2=$(lighten $r2 $fac)
    g1=$(lighten $g1 $fac)
    g2=$(lighten $g2 $fac)
    b1=$(lighten $b1 $fac)
    b2=$(lighten $b2 $fac)
    pos=$((pos + 2))
done

#Command Number
CMDNR="\!"
#User
U="\[\033[38;2;$r1;$g1;${b1}m\]\u\[\033[00m\]"

#Host
H="\[\033[38;2;$r2;$g2;${b2}m\]\h\[\033[00m\]"

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
PS1="$DATE - $DIR"'$(scm_ps1)'"$ROOT\n$CMDNR $U@$H $RETURN \$ " #schnell

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

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
bind '"\eOC":forward-word'
bind '"\eOD":backward-word'

function update_dotfiles() {
	if [ "$(which git)" ]; then
		if [ ! -e ~/dotfiles/ ] ; then
			# use the ssh variant if it's me
			if [ -e "~/.ssh/id_rsa" -a \( "$USER" = "bastian" -o "$USER" = "bg" -o "$USER" = "bdegroot" \) ] ; then
				git clone git@github.com:bastiandg/dotfiles.git ~/dotfiles
			else
				git clone https://github.com/bastiandg/dotfiles.git ~/dotfiles
			fi
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

# enable programmable completion features
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

if [ -e ~/.bashrc.local ] ; then
	. ~/.bashrc.local
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
