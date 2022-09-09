#!/bin/sh

alert_local() {
    tput setaf 6
    echo $1
    tput sgr0
}

if [ $# -eq 1 ]; then
    # Fresh install
    sudo apt install zsh tmux vim vim-gui-common curl git vlc xclip python3 python3-dev python3-pip python3-tk -y
    sudo apt install build-essential cmake android-tools-adb android-tools-fastboot -y
    sudo apt install curl wget unrar rsync -y
    sudo apt install nala
    python3 -m pip install scipy numpy opencv-contrib-python matplotlib --user
    python3 -m pip install tensorflow tensorboard datetime --user

    # Fzf
    alert_local 'Installing Fzf'
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install

    # Vim Plug
    alert_local 'Setting Up vim Plug'
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    # Tmux Plugin Manager
    alert_local 'Setting up Tmux Plugin Manager'
    mkdir ~/.tmux
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

#################################################################################
################ Setting up the dotfiles in its specific locations ##############
#################################################################################
# Setup Vimrc
alert_local 'Setting Up Vim'
ln -i vimrc ~/.vimrc

# Setup Zshrc
alert_local 'Setting Up Zsh'
ln -i zshrc ~/.zshrc

# Setup Zsh_alias
alert_local 'Setting Up Alias'
ln -i zsh_alias ~/.zsh_alias

# Setuo the Tmux Configuration
alert_local 'Setting Up Tmux Configuration'
ln -i 'tmux.conf' ~/.tmux.conf

# Source Zshrc
alert_local "Update your terminal right now using $(tput sgr0) \
    '. ~/.zshrc $(tput setaf 6)' Command."

###################################################################################
##################################### Misc. #######################################
###################################################################################
# Setting Up Vim Plugins
alert_local 'Installing Vim Plugins'
vim +PlugInstall +qall
