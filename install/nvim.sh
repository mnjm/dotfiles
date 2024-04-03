#!/usr/bin/env bash

. $DOTFILES/install/setup_utils.sh

# Install and setup neovim
mkdir -p "$HOME/softwares"
curl -L https://github.com/neovim/neovim/releases/latest/download/nvim.appimage -o $HOME/softwares/nvim.appimage
chmod u+x $HOME/softwares/nvim.appimage
_link_file $HOME/softwares/nvim.appimage ~/.local/bin/nvim
