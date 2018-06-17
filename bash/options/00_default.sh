#vim the one and only
export EDITOR=/usr/bin/vim

# colorful manpages
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
if [ -d "$HOME/scripts" ]; then
	export PATH="$HOME/scripts:$PATH"
fi

if [ -d "$HOME/go/bin" ] ; then
	export PATH="$PATH:$HOME/go/bin"
fi

# depends on https://github.com/bastiandg/setup/blob/master/packages/diff-so-fancy.sh
if [ -x "/opt/diff-so-fancy/diff-so-fancy" ] ; then
	export GIT_PAGER="/opt/diff-so-fancy/diff-so-fancy | less --tabs=4 -RX"
fi

#vim as manpager
export MANPAGER="/bin/sh -c \"col -b | vim -c 'set ft=man ts=8 nomod nolist nonu noma' -c 'map q :q<CR>' -\""

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# history search with the arrow keys
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\eOC":forward-word'
bind '"\eOD":backward-word'
bind 'set completion-ignore-case on'

export LANG=en_US.UTF-8

