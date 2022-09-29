#!/usr/bin/env bash

. $DOTFILES/setup_utils.sh

# Install and setup neovim
mkdir -p ~/softwares
pushd ~/softwares
wget "https://github.com/neovim/neovim/releases/download/v0.8.0/nvim-linux64.deb"
sudo dpkg -i nvim-linux64.deb
popd

# Install packer.nvim (Package Manager for nvim)
git -C ~/.local/share/nvim/site/pack/packer/start/packer.nvim pull ||\
    git clone --depth 1 https://github.com/wbthomason/packer.nvim\
    ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# Setting up configurations
./nvim/create_links_lua.sh
nvim +PackerSync +qall
