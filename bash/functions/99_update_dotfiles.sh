update_dotfiles() {
  if command -v git &>/dev/null; then
    if [[ ! -e ~/dotfiles/ ]]; then
      # use the ssh variant if it's me
      if [ -e "$HOME/.ssh/id_rsa" -a \( "$USER" = "bastian" -o "$USER" = "bg" -o "$USER" = "bdegroot" \) ]; then
        git clone --recursive git@github.com:bastiandg/dotfiles.git "$HOME/dotfiles"
      else
        git clone --recursive https://github.com/bastiandg/dotfiles.git "$HOME/dotfiles"
      fi
    else
      (cd "$HOME/dotfiles/" && git pull && git submodule update --init --recursive)
    fi
    cp -r "$HOME/dotfiles/bash_profile" "$HOME/.bash_profile"
    cp -r "$HOME/dotfiles/bashrc" "$HOME/.bashrc"
    rm -rf "$HOME/.bash"
    cp -r "$HOME/dotfiles/bash" "$HOME/.bash"
    if command -v helm &>/dev/null; then
      helm completion bash >"$HOME/.bash/completions/helm.sh"
    fi
    if command -v kubectl &>/dev/null; then
      kubectl completion bash >"$HOME/.bash/completions/kubectl.sh"
    fi
    if command -v nvim &>/dev/null; then
      rm -rf "$HOME/.vim/" "$HOME/.vimrc" "$HOME/.config/nvim"
      ln -s "$HOME/.vim/init.vim" "$HOME/.vimrc"
      cp -r "$HOME/dotfiles/vim" "$HOME/.vim"
      ln -s "$HOME/.vim" "$HOME/.config/nvim"
      nvim +PlugInstall +qall
      pip3 install --upgrade neovim
      pip3 install --upgrade python-language-server black pyls-black
      if command -v go &>/dev/null; then
        GO111MODULE=on go get golang.org/x/tools/gopls@latest
      fi
      nvim +UpdateRemotePlugins +qall
    fi
  else
    echo "git is not installed"
  fi
  source "$HOME/.bashrc"
}
