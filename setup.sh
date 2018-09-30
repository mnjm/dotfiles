#!/bin/sh
# Setting up the dotfiles in its specific locations

# Setup Vimrc
echo Setting Up Vim
ln -i vimrc ~/.vimrc

# Setup Zshrc
echo Setting Up Zsh
ln -i zshrc ~/.zshrc

# Setup Zsh_alias
echo Setting Alias
ln -i zsh_alias ~/.zsh_alias

# Setup the Terminal Theme
echo Setting Up Zsh Terminal Theme
ln -i my_amuse ~/.oh-my-zsh/themes/amuse.zsh-theme

# Source Zshrc
szrc
