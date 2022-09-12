#!/bin/sh

# TODO Test the installation and add fail safe
# Install and setup neovim
alert_local 'Building and installing neovim from source'
mkdir ~/softwares
git clone https://github.com/neovim/neovim ~/softwares/neovim
pushd ~/softwares/neovim
git checkout stable
sudo make install
# sudo cmake --build build/ --target uninstall # to Uninstall
# Install packer.nvim (Package Manager for nvim)
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
    ~/.local/share/nvim/site/pack/packer/start/packer.nvim
popd
mkdir -p ~/.config/nvim
ln -s nvim/init.lua ~/.config/nvim/init.lua
nvim +PackerSync +qall
