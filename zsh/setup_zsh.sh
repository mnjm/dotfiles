#!/usr/bin/env bash

. $DOTFILES/setup_utils.sh

_alert_local "Attempting to link .zshrc"
_link_file $DOTFILES/zsh/zshrc ~/.zshrc
touch ~/.zsh_history -a

# Setup Zsh Plugins
mkdir -p ~/.zsh
# Zsh Autosuggestions
_alert_local "Downloading/Updating zsh-autosuggestions"
_git_clone_pull https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
# Zsh Syntax Highlight
_alert_local "Downloading/Updating zsh-syntx-highlighting"
 _git_clone_pull https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting

 mkdir -p ~/.zsh/zsh_functions
