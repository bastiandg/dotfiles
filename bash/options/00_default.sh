#vim the one and only
export EDITOR=nvim

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

if [[ -d "/opt/appimage" ]]; then
  export PATH="$PATH:$HOME/go/bin"
fi

if [[ -d "$HOME/go/bin" ]]; then
  export PATH="$PATH:$HOME/go/bin"
fi

if [[ -d "/usr/local/go/bin/" ]]; then
  export PATH="$PATH:/usr/local/go/bin/"
fi

if [[ -d "$HOME/.local/bin" ]]; then
  export PATH="$PATH:$HOME/.local/bin"
fi

#vim as manpager
export MANPAGER="/bin/sh -c \"col -b | nvim -c 'set ft=man ts=8 nomod nolist nonu noma' -c 'map q :q<CR>' -\""

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# history search with the arrow keys
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\eOC":forward-word'
bind '"\eOD":backward-word'
bind 'set input-meta on'
bind 'set output-meta on'
bind 'set convert-meta off'
bind 'set completion-ignore-case on'
bind '"\C-p": shell-kill-word'

export LANG=en_US.UTF-8
