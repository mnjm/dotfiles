#!/bin/sh

ln -s vim/vimrc ~/.vimrc
# Vim Plug
alert_local 'Setting Up vim Plug'
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# Setting Up Vim Plugins
alert_local 'Installing Vim Plugins'
vim +PlugInstall +qall
