#!/bin/sh
mkdir -p ~/.config/nvim/lua
mkdir -p ~/.config/nvim/plugin
find .       -maxdepth 1 -type f -name "*.lua" -exec cp -vs "$PWD/{}" ~/.config/nvim/ ';'
find lua     -maxdepth 1 -type f -name "*.lua" -exec cp -vs "$PWD/{}" ~/.config/nvim/lua/ ';'
find plugin  -maxdepth 1 -type f -name "*.lua" -exec cp -vs "$PWD/{}" ~/.config/nvim/plugin/ ';'
