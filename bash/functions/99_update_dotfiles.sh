update_dotfiles() {
	if [ "$(which git)" ]; then
		if [ ! -e ~/dotfiles/ ] ; then
			# use the ssh variant if it's me
			if [ -e "$HOME/.ssh/id_rsa" -a \( "$USER" = "bastian" -o "$USER" = "bg" -o "$USER" = "bdegroot" \) ] ; then
				git clone --recursive git@github.com:bastiandg/dotfiles.git "$HOME/dotfiles"
			else
				git clone --recursive https://github.com/bastiandg/dotfiles.git "$HOME/dotfiles"
			fi
		else
			(cd "$HOME/dotfiles/" && gu )
		fi
		cp -r "$HOME/dotfiles/bash_profile" "$HOME/.bash_profile"
		cp -r "$HOME/dotfiles/bashrc" "$HOME/.bashrc"
		rm -rf "$HOME/.bash"
		cp -r "$HOME/dotfiles/bash" "$HOME/.bash"
		rm "$HOME/.bash/completions/vault-bash-completion/run-tests.sh" # TODO shitty workaround
		if [ -n "$(which nvim)" ] ; then
			rm -rf "$HOME/.vim/" "$HOME/.vimrc" "$HOME/.config/nvim"
			ln -s "$HOME/.vim/init.vim" "$HOME/.vimrc"
			cp -r "$HOME/dotfiles/vim" "$HOME/.vim"
			ln -s "$HOME/.vim" "$HOME/.config/nvim"
			nvim +PlugInstall +qall
			pip3 install --upgrade neovim
			nvim +UpdateRemotePlugins +qall
		fi
	else
		echo "git is not installed"
	fi
	source "$HOME/.bashrc"
}
