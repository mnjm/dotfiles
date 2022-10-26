#!/usr/bin/env bash

. $DOTFILES/install/setup_utils.sh

# Install and setup neovim
take ~/softwares
curl -kLO "https://github.com/neovim/neovim/releases/download/v0.8.0/nvim-linux64.deb"
sudo dpkg -i nvim-linux64.deb
popd

# Install packer.nvim (Package Manager for nvim)
git -C ~/.local/share/nvim/site/pack/packer/start/packer.nvim pull ||\
    git clone --depth 1 https://github.com/wbthomason/packer.nvim\
    ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# Setting up configurations
nvim +"source $DOTFILES/nvim/.config/nvim/lua/plugins.lua" +PackerSync +qall # TODO: Test This

# Lua LSP
take ~/softwares/lua-language-server
curl -L https://github.com/sumneko/lua-language-server/releases/download/3.5.6/lua-language-server-3.5.6-linux-x64.tar.gz | tar xz
_link_file ./bin/lua-language-server ~/.local/bin/lua-language-server
popd

# Python LSP
sudo npm -g install pyright

# Rust LSP
curl -L https://github.com/rust-lang/rust-analyzer/releases/latest/download/rust-analyzer-x86_64-unknown-linux-gnu.gz | gunzip -c - > ~/.local/bin/rust-analyzer
chmod +x ~/.local/bin/rust-analyzer
