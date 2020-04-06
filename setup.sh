#!/bin/sh

#################################################################################
##################### Install the applications needed. ##########################
#################################################################################
tput setaf 6; echo 'Installing Zsh, Vim, tmux etc'; tput sgr0

sudo apt install zsh tmux vim vim-common vim-gnome vim-gui-common vim-runtime vim-tiny curl -y
sudo apt install git vlc xclip python-dev python-pip python3-dev python3-pip -y
sudo apt install build-essential cmake libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev -y
sudo apt install libswscale-dev libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev -y
sudo apt install libjasper-dev libdc1394-22-dev shutter python-tk python3-tk -y
sudo apt install unrar android-tools-adb android-tools-fastboot -y

python -m pip install pip --upgrade
python3 -m pip install pip --upgrade
python -m pip install tensorflow==1.14.0 tensorboard==1.14.0 dlib==19.19.0 --user
python -m pip install keras scipy scikit-learn opencv-contrib-python==3.4.8.29 --user
python -m pip install matplotlib --user
python3 -m pip install tensorflow==1.14.0 tensorboard==1.14.0 dlib==19.19.0 --user
python3 -m pip install keras scipy scikit-learn opencv-contrib-python==3.4.8.29 --user
python3 -m pip install matplotlib --user

# Fzf
tput setaf 6; echo 'Installing Fzf'; tput sgr0
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

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
