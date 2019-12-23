#!/bin/sh

#################################################################################
##################### Install the applications needed. ##########################
#################################################################################
# Zsh
tput setaf 6; echo 'Installing Zsh'; tput sgr0
sudo apt install zsh -y

# Vim
tput setaf 6; echo 'Installing Vim'; tput sgr0
sudo apt install vim -y

# Fzf
tput setaf 6; echo 'Installing Fzf'; tput sgr0
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# Tmux
tput setaf 6; echo 'Installing tmux'; tput sgr0
sudo apt install tmux -y

# Oh-My-Zsh
tput setaf 6; echo 'Setting up Oh-My-Zsh'; tput sgr0
sh -c \
    "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Vim Plug
tput setaf 6; echo 'Setting Up vim Plug'; tput sgr0
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

#################################################################################
################ Setting up the dotfiles in its specific locations ##############
#################################################################################
# Setup Vimrc
tput setaf 6; echo 'Setting Up Vim'; tput sgr0
ln -i vimrc ~/.vimrc

# Setup Zshrc
tput setaf 6; echo 'Setting Up Zsh'; tput sgr0
ln -i zshrc ~/.zshrc

# Setup Zsh_alias
tput setaf 6; echo 'Setting Up Alias'; tput sgr0
ln -i zsh_alias ~/.zsh_alias

# Setup the Terminal Theme
tput setaf 6; echo 'Setting Up Zsh Terminal Theme'; tput sgr0
ln -i my_amuse ~/.oh-my-zsh/themes/my_amuse.zsh-theme

# Setuo the Tmux Configuration
tput setaf 6; echo 'Setting Up Tmux Configuration'; tput sgr0
ln -i 'tmux.conf' ~/.tmux.conf

# Source Zshrc
tput setaf 6; echo "Update your terminal right now using $(tput sgr0) \
    '. ~/.zshrc $(tput setaf 6)' Command."; tput sgr0

###################################################################################
##################################### Misc. #######################################
###################################################################################
# Setting Up Vim Plugins
tput setaf 6; echo 'Installing Vim Plugins'; tput sgr0
vim +PlugInstall +qall
