#!/usr/bin/env bash

. $DOTFILES/setup_utils.sh

_link_file $DOTFILES/zsh/zshenv ~/.zshenv

_alert_local "Attempting to link .zshrc"
mkdir -p ~/.config/zsh
_link_file $DOTFILES/zsh/zshrc ~/.config/zsh/.zshrc
mkdir -p ~/.cache
touch ~/.cache/zsh_history -a

# Setup Zsh Plugins

# Zsh Autosuggestions
_alert_local "Downloading/Updating zsh-autosuggestions"
_git_clone_pull https://github.com/zsh-users/zsh-autosuggestions ~/.config/zsh/zsh-autosuggestions
# Zsh Syntax Highlight
_alert_local "Downloading/Updating zsh-syntx-highlighting"
 _git_clone_pull https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.config/zsh/zsh-syntax-highlighting

 mkdir -p ~/.config/zsh/zsh_function/
