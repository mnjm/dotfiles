#!/usr/bin/env bash

# WARNING: This script is not mainitained. Pls check the neovim's github for detailed installation guide

. $DOTFILES/setup_utils.sh

# Install and setup neovim

# TODO Test the installation and add fail safe

_alert_local "Downloading/Updating neovim repo"
mkdir -p ~/softwares
if [ -d '~/softwares/neovim/.git' ]; then
    pushd ~/softwares/neovim
    git checkout master
    git pull
    popd
else
    git clone https://github.com/neovim/neovim ~/softwares/neovim
fi

_alert_local "Building neovim"
pushd ~/softwares/neovim
# Install stable version of neovim
git checkout stable
make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install
popd
# sudo cmake --build build/ --target uninstall # to uninstall neovim

# Install packer.nvim (Package Manager for nvim)
git -C ~/.local/share/nvim/site/pack/packer/start/packer.nvim pull ||\
    git clone --depth 1 https://github.com/wbthomason/packer.nvim\
    ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# Setting up configurations
./nvim/create_links_lua.sh
nvim +PackerSync +qall
