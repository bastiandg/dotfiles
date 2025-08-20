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

paths=(
  "${HOME}/go/bin"
  "${HOME}/.local/go/bin/"
  "/usr/local/go/bin/"
  "${HOME}/.local/bin"
  "${HOME}/.cargo/bin"
)

if command -v npm &>/dev/null; then
  paths+=("$(npm config get prefix)/bin")
fi

for path in "${paths[@]}"; do
  if [[ -d "$path" ]]; then
    export PATH="${PATH}:${path}"
  fi
done

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
