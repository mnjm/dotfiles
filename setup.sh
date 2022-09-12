#!/bin/sh

alert_local() {
    color=${2:-6}
    tput setaf $color; echo $1; tput sgr0
}

#############################################################
######################### Apt Packages ######################
#############################################################
alert_local "Installing apt packages"
sudo apt install zsh zsh-doc tmux vim vim-gui-common git vlc xclip -y
sudo apt install python3 python3-dev python3-pip python3-tk -y
sudo apt install build-essential cmake android-tools-adb android-tools-fastboot -y
sudo apt install curl wget unrar rsync -y
sudo apt install nala htop -y
sudo apt install ninja-build gettext libtool-bin autoconf automake -y
sudo apt install g++ pkg-config unzip doxygen -y
sudo apt install ghostwriter -y
python3 -m pip install scipy numpy opencv-contrib-python matplotlib --user
python3 -m pip install tensorflow tensorboard datetime --user

#############################################################
#################### FZF: Fuzzy File Finder #################
#############################################################
# Fzf
alert_local 'Installing Fzf'
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
if [ -f ~/.fzf/install ]; then
    ~/.fzf/install --all --no-bash
else
    alert_local "Fzf installation failed" 1
fi

############################################################
###################### VIM Text Editor #####################
############################################################
Setup Vimrc
alert_local 'Setting Up Vim'
. ./vim/setup_vim.sh || alert_local "Vim setup failed" 1

############################################################
######################## ZSH Shell #########################
############################################################
 # Setup Zshrc
alert_local 'Setting Up Zsh'
. ./zsh/setup_zsh.sh || alert_local "Zsh setup failed" 1

############################################################
############### TMUX: Terminal Mutiplexer ##################
############################################################
 # Setup the Tmux Configuration
alert_local 'Setting Up Tmux Configuration'
. ./tmux/setup_tmux.sh || alert_local "Tmux setup failed" 1

############################################################
################### Neo-Vim Text Editor ####################
############################################################
alert_local 'Installing nvim'
. ./nvim/setup_nvim.sh || alert_local "Nvim setup failed" 1

############################################################
################### Change Shell  ##########################
############################################################
# Change shell to zsh
alert_local "Changing default sh to zsh"
chsh -s $(which zsh)

alert_local "Relaunch terminal now"
