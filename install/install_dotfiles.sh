#!/usr/bin/env bash

. $DOTFILES/install/setup_utils.sh

if ! command -v stow &>/dev/null; then
    sudo apt install stow -y
fi

stdt="$DOTFILES/bin/dot-local/bin/stow-dotfiles"
$stdt alacritty
$stdt bin
$stdt git
$stdt htop
$stdt lf
# $stdt marktext
$stdt neofetch
$stdt nvim
$stdt rofi
$stdt tmux
$stdt vim
$stdt zsh
