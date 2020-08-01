#!/bin/sh
if [ $# -eq 1 ]; then
    # Fresh install
    sudo apt install zsh tmux vim vim-gui-common curl git vlc xclip python3 python3-dev python3-pip python3-tk -y
    sudo apt install build-essential cmake android-tools-adb android-tools-fastboot -y
    sudo apt install python-is-python3 -y
    sudo apt install curl wget unrar rsync -y
    python3 -m pip install scipy numpy opencv-contrib-python matplotlib --user
    python3 -m pip install tensorflow tensorboard datetime --user

    # Fzf
    tput setaf 6; echo 'Installing Fzf'; tput sgr0
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install

    # Oh-My-Zsh
    tput setaf 6; echo 'Setting up Oh-My-Zsh'; tput sgr0
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

    # Vim Plug
    tput setaf 6; echo 'Setting Up vim Plug'; tput sgr0
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

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
