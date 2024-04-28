#!/usr/bin/env bash

. $DOTFILES/install/setup_utils.sh

# Vim Plug
_alert_local 'Setting Up vim Plug'
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# Setting Up Vim Plugins
_alert_local 'Installing Vim Plugins'
vim +"source $DOTFILES/vim/.vimrc" +PlugInstall +qall
