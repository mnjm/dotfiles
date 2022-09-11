#!/bin/sh

alert_local() {
    color=${2:-6}
    tput setaf $color; echo $1; tput sgr0
}

#############################################################
######################### Apt Packages ######################
#############################################################
alert_local "Installing apt packages"
sudo apt install zsh zsh-doc tmux vim vim-gui-common curl git vlc xclip python3 python3-dev python3-pip python3-tk -y
sudo apt install build-essential cmake android-tools-adb android-tools-fastboot -y
sudo apt install curl wget unrar rsync -y
sudo apt install nala htop -y
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

#############################################################
####################### VIM Text Editor #####################
#############################################################
#Setup Vimrc
alert_local 'Setting Up Vim'
ln -s vim/vimrc ~/.vimrc
# Vim Plug
alert_local 'Setting Up vim Plug'
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# Setting Up Vim Plugins
alert_local 'Installing Vim Plugins'
vim +PlugInstall +qall

############################################################
######################## ZSH Shell #########################
############################################################
# Setup Zshrc
alert_local 'Setting Up Zsh'
ln -s zsh/zshrc ~/.zshrc
touch ~/.zsh_history
# Setup Zsh Plugins
mkdir -p ~/.zsh
# Zsh Autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
# Zsh Syntax Highlight
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting

############################################################
############### TMUX: Terminal Mutiplexer ##################
############################################################
# Setup the Tmux Configuration
alert_local 'Setting Up Tmux Configuration'
ln -s tmux/tmux.conf ~/.tmux.conf
# Tmux Plugin Manager
alert_local 'Setting up Tmux Plugin Manager'
mkdir -p ~/.tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
alert_local 'Installing tmux plugins'
if [ -f ~/.tmux/plugins/tpm/tpm ]  && [ -f ~/.tmux/plugins/tpm/bin/install_plugins ]; then
    ~/.tmux/plugins/tpm/tpm
    export TMUX_PLUGIN_MANAGER_PATH=$HOME/.tmux/plugins/tpm
    ~/.tmux/plugins/tpm/bin/install_plugins
else
    alert_local "Tpm installation failed" 1
fi

############################################################
################### Neo-Vim Text Editor ####################
############################################################
# TODO Test the installation and add fail safe
# Install and setup neovim
alert_local 'Building and installing neovim from source'
sudo apt install ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen -y
git clone https://github.com/neovim/neovim ~/softwares/neovim
pushd ~/softwares/neovim
git checkout stable
sudo make install
# sudo cmake --build build/ --target uninstall # to Uninstall
# Install packer.nvim (Package Manager for nvim)
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
mkdir -p ~/.config/nvim
ln -s nvim/init.lua ~/.config/nvim/init.lua
nvim +PackerSync +qall

############################################################
################### Change Shell  ##########################
############################################################
# Change shell to zsh
alert_local "Changing default sh to zsh"
chsh -s $(which zsh)

alert_local "Relaunch terminal now"
