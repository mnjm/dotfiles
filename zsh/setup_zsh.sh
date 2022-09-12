#!/bin/sh

# TODO: Do pull if cloned

ln -s zsh/zshrc ~/.zshrc
touch ~/.zsh_history
# Setup Zsh Plugins
mkdir -p ~/.zsh
# Zsh Autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
# Zsh Syntax Highlight
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
