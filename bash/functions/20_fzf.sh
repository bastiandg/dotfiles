export FZF_DEFAULT_COMMAND="fdfind --type file --color=always"
#export FZF_DEFAULT_OPTS="--no-mouse --ansi"
export FZF_DEFAULT_OPTS="--no-mouse --height 50% --reverse --ansi --inline-info --preview='[[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file || (batcat -pp --color=always {} || cat {}) | head -300' --preview-window='right:nohidden:wrap' --bind='f3:execute(batcat -pp --color=always {} | less -R || less -f {}),f2:toggle-preview'"

# Auto-completion
# ---------------
if [[ $- == *i* ]]; then
  source "$HOME/.fzf/shell/completion.bash" 2>/dev/null
fi

if [[ -x "${HOME}/.fzf/bin/fzf" ]]; then
  PATH="${PATH}:${HOME}/.fzf/bin/"
fi

# Key bindings
# ------------
source "${HOME}/.fzf/shell/key-bindings.bash"
