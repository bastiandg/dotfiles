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
    rm -rf "$HOME/.config/wezterm"
    cp -r "$HOME/dotfiles/wezterm/" "$HOME/.config/wezterm"
    if command -v nvim &>/dev/null; then
      rm -rf "$HOME/.vim/" "$HOME/.vimrc" "$HOME/.config/nvim"
      cp -r "$HOME/dotfiles/lazyvim" "$HOME/.config/nvim"
    fi
  else
    echo "git is not installed"
  fi
  source "$HOME/.bashrc"
}
