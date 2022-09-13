#!/bin/sh

# Install and setup neovim

# TODO Test the installation and add fail safe
alert_local 'Building and installing neovim from source'
mkdir ~/softwares
git clone https://github.com/neovim/neovim ~/softwares/neovim
pushd ~/softwares/neovim
git checkout stable
sudo make install
popd
# sudo cmake --build build/ --target uninstall # to uninstall neovim


# Install packer.nvim (Package Manager for nvim)
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
    ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# Setting up configurations
source ./nvim/create_links_lua.sh
nvim +PackerSync +qall
