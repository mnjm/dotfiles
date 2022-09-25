#!/usr/bin/env bash

. $DOTFILES/setup_utils.sh

_alert_local "Atempting to link vimrc"
ln -vs $DOTFILES/vim/vimrc ~/.vimrc || ls -l ~/.vimrc
# Vim Plug
_alert_local 'Setting Up vim Plug'
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# Setting Up Vim Plugins
_alert_local 'Installing Vim Plugins'
vim +PlugInstall +qall