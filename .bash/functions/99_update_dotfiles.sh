update_dotfiles() {
	if [ "$(which git)" ]; then
		if [ ! -e ~/dotfiles/ ] ; then
			# use the ssh variant if it's me
			if [ -e "$HOME/.ssh/id_rsa" -a \( "$USER" = "bastian" -o "$USER" = "bg" -o "$USER" = "bdegroot" \) ] ; then
				git clone git@github.com:bastiandg/dotfiles.git "$HOME/dotfiles"
			else
				git clone https://github.com/bastiandg/dotfiles.git "$HOME/dotfiles"
			fi
			(cd "$HOME/dotfiles" && git submodule init && git submodule update )
		else
			(cd "$HOME/dotfiles/" && git pull && git submodule init && git submodule update )
		fi
		cp -r "$HOME/dotfiles/.bashrc" "$HOME/.bashrc"
		rm -rf "$HOME/.bash"
		cp -r "$HOME/dotfiles/.bash" "$HOME/.bash"
		rm -rf "$HOME/.vim/" "$HOME/.vimrc"
		cp -r "$HOME/dotfiles/.vimrc" "$HOME/.vimrc"
		cp -r "$HOME/dotfiles/.vim" "$HOME/.vim"
	else
		echo "git is not installed"
	fi
}


