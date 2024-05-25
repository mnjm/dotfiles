#!/usr/bin/env bash

. $HOME/.dotfiles/install/setup_utils.sh

mkdir -p ~/.config/zsh/zsh_function
mkdir -p ~/.cache
touch ~/.cache/zsh_history -a

# Setup Zsh Plugins

# Zsh Autosuggestions
_alert_local "Downloading/Updating zsh-autosuggestions"
_git_clone_pull https://github.com/zsh-users/zsh-autosuggestions ~/.config/zsh/zsh-autosuggestions
# Zsh Syntax Highlight
_alert_local "Downloading/Updating zsh-syntx-highlighting"
 _git_clone_pull https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.config/zsh/zsh-syntax-highlighting
