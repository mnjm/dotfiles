#!/usr/bin/env bash

. $HOME/.dotfiles-misc/install/setup_utils.sh

# install node
_alert_local "Installing node"
dest=~/softwares/nodejs
mkdir -p $dest
curl -L https://nodejs.org/dist/v20.12.2/node-v20.12.2-linux-x64.tar.xz | tar -xJC $dest --strip-components 1
# linking bins
_link_file $dest/bin/node ~/.local/bin/node
_link_file $dest/bin/npm ~/.local/bin/npm
_link_file $dest/bin/npx ~/.local/bin/npx

# Install and setup neovim
mkdir -p "$HOME/softwares"
curl -L https://github.com/neovim/neovim/releases/latest/download/nvim.appimage -o $HOME/softwares/nvim.appimage
chmod u+x $HOME/softwares/nvim.appimage
_link_file $HOME/softwares/nvim.appimage ~/.local/bin/nvim
