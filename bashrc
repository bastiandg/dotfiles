# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# enable programmable completion features
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    source /etc/bash_completion
fi

# source options aliases completions and functions
SECTIONS="options aliases completions functions"
for section in $SECTIONS ; do
	if [ -d "$HOME/.bash/$section" ] ; then
		for source_file in $(find "$HOME/.bash/$section" -type f -iname "*.sh" | sort) ; do
			source "$source_file"
		done
	fi
done

source "$HOME/.bash/prompt/fancy.sh"

if [ -e  "$HOME/.local-aliases" ]; then
	source "$HOME/.local-aliases"
fi

if [ -e "$HOME/.bashrc.local" ] ; then
	source "$HOME/.bashrc.local"
fi
