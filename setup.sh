#!/bin/sh

alert_local() {
    tput setaf 6; echo $1; tput sgr0
}

# Fresh install
alert_local "Installing packages"
sudo apt install zsh zsh-autosuggestions zsh-doc tmux vim vim-gui-common curl git vlc xclip python3 python3-dev python3-pip python3-tk -y
sudo apt install build-essential cmake android-tools-adb android-tools-fastboot -y
sudo apt install curl wget unrar rsync -y
sudo apt install nala htop -y
python3 -m pip install scipy numpy opencv-contrib-python matplotlib --user
python3 -m pip install tensorflow tensorboard datetime --user

# Fzf
alert_local 'Installing Fzf'
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# Setup Vimrc
alert_local 'Setting Up Vim'
ln -i vimrc ~/.vimrc
# Vim Plug
alert_local 'Setting Up vim Plug'
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# Setting Up Vim Plugins
alert_local 'Installing Vim Plugins'
vim +PlugInstall +qall

# Setup Zshrc
alert_local 'Setting Up Zsh'
ln -i zshrc ~/.zshrc
touch ~/.zsh_history

# Setup Zsh_alias
alert_local 'Setting Up Alias'
ln -i zsh_alias ~/.zsh_alias

# Setuo the Tmux Configuration
alert_local 'Setting Up Tmux Configuration'
ln -i 'tmux.conf' ~/.tmux.conf
# Tmux Plugin Manager
alert_local 'Setting up Tmux Plugin Manager'
mkdir -p ~/.tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
alert_local 'Installing tmux plugins'
~/.tmux/plugins/tpm/tpm && ~/.tmux/plugins/tpm/bin/install_plugins

# Change shell to zsh
alert_local "Changing default sh to zsh"
chsh -s $(which zsh)
