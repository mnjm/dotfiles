#!/usr/bin/env bash

# remove broken symlinks
find -L ~/.config/nvim -type l -exec rm -- {} +
mkdir -p ~/.config/nvim/lua
mkdir -p ~/.config/nvim/plugin
find $DOTFILES/nvim         -maxdepth 1 -type f -name "*.lua" -exec cp -vs "{}" ~/.config/nvim/ ';'
find $DOTFILES/nvim/lua     -maxdepth 1 -type f -name "*.lua" -exec cp -vs "{}" ~/.config/nvim/lua/ ';'
find $DOTFILES/nvim/plugin  -maxdepth 1 -type f -name "*.lua" -exec cp -vs "{}" ~/.config/nvim/plugin/ ';'
ls --color=auto -l ~/.config/nvim
ls --color=auto -l ~/.config/nvim/lua
ls --color=auto -l ~/.config/nvim/plugin
