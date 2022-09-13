#!/usr/bin/env bash

. $DOTFILES/setup_utils.sh

_alert_local "Attempting to link .zshrc"
ln -vs $DOTFILES/zsh/zshrc ~/.zshrc || ls -l ~/.zshrc
touch ~/.zsh_history
# Setup Zsh Plugins
mkdir -p ~/.zsh
# Zsh Autosuggestions
_alert_local "Downloading/Updating zsh-autosuggestions"
git -C ~/.zsh/zsh-autosuggestions pull || \
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
_alert_local "Downloading/Updating zsh-syntx-highlighting"
# Zsh Syntax Highlight
git -C ~/.zsh/zsh-syntax-highlighting pull || \
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
