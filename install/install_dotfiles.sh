#!/usr/bin/env bash

. $DOTFILES/install/setup_utils.sh

if ! command -v stow &>/dev/null; then
    sudo apt install stow -y
fi

stow-dotfiles alacritty
stow-dotfiles lf
stow-dotfiles nvim
stow-dotfiles rofi
stow-dotfiles tmux
stow-dotfiles vim
stow-dotfiles zsh
stow-dotfiles git
# stow-dotfiles marktext
stow-dotfiles htop
