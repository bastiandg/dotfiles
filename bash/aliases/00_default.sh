# aliases
alias vim=nvim
alias todo='vim -o ~/todo.md ~/notizen.md "+windo set nonumber" "+windo set nolist" "+windo set fcs=eob:\ " "+SyntasticToggleMode"'
alias watch='watch '
alias ls='ls -F -h --color=auto'
alias ll='ls -lN'
alias la='ls -laN'
alias lla='ls -laN'
alias l='ls -lN'
alias cp='cp -vr'
alias mv='mv -v'
alias rm='rm -v'
alias du='du -ch'
alias grep="grep --color=auto"
alias clip='xclip -selection clipboard'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias hg='history | grep -i'
alias diff="diff -u"
alias utop='top -u "$USER"'
alias irc='screen -x irc'
alias vla='virsh list --all'
alias g='grep'
alias mkdir='mkdir -p'
alias df='df -h'
alias v='nvim'
alias dusch='du -csh * | sort -rh | head -11' # Lists folders and files sizes in the current folder
alias abs='readlink -f' #shows the absolute path
alias sx="screen -x"
alias webserver="python -m SimpleHTTPServer 8080"
alias cx="chmod +x"
alias mtr="mtr -t" #curses and no X for mtr
alias il='ip addr | grep inet | sed -e "s#\s*inet \([0-9.]*\).*\ \([a-z0-9]*\)#\2 \1#g"'
alias txt='vim -c "set wrap linebreak nolist nonumber noshowmode noruler laststatus=0 noshowcmd"' # for reading texts
alias cl='crontab -l'
alias ce='crontab -e'
alias pycalc="python -i -c \"from math import *; import readline; import rlcompleter; readline.parse_and_bind('tab: complete')\""
alias gu='git pull && git submodule update --init --recursive'
alias g1="git diff HEAD~1"
alias -- -='cd -'
alias text='NVIM_TUI_ENABLE_TRUE_COLOR=0 vim -u ~/.vim/mail.vim +Goyo'
alias gc="gcloud"
alias tm='cd "$(mktemp -d)"'
alias tree='tree --dirsfirst'

if command -v batcat &> /dev/null ; then
	alias cat="batcat -pp"
	alias bat="batcat -pp"
fi

#colourise
if command -v /usr/bin/grc ; then
	alias ping='grc ping'
fi

#use htop instead of top
if [ -e /usr/bin/htop ]
then
	alias top='htop'
fi


