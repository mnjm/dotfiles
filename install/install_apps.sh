#!/usr/bin/env bash

export DOTFILES=$PWD

. $DOTFILES/install/setup_utils.sh

#############################################################
######################### Apt+Pip Packages ##################
#############################################################
_alert_local "Installing apt packages"
sudo apt install nala -y
xargs -a apt-packages.list sudo nala install -y
_alert_local "Installing pip packages"
xargs -a pip-packages.list python3 -m pip install --user
#
#############################################################
######################### Nerd Font #########################
#############################################################
_alert_local "Installing Nerd Fonts"
mkdir -p ~/.fonts
curl -kL https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/UbuntuMono.zip -o /tmp/UbuntuMono.zip
unzip /tmp/UbuntuMono.zip -d "$HOME/.fonts/UbuntuMono"
fc-cache -fv || _alert_local "Fonts install failed" 1
rm /tmp/UbuntuMono.zip

############################################################
###################### VIM Text Editor #####################
############################################################
# Setup Vimrc
_alert_local 'Setting Up Vim'
./setup_vim.sh || _alert_local "Vim setup failed" 1

############################################################
######################## ZSH Shell #########################
############################################################
 # Setup Zshrc
_alert_local 'Setting Up Zsh'
./setup_zsh.sh || _alert_local "Zsh setup failed" 1

############################################################
############### TMUX: Terminal Mutiplexer ##################
############################################################
 # Setup the Tmux Configuration
_alert_local 'Setting Up Tmux Configuration'
./setup_tmux.sh || _alert_local "Tmux setup failed" 1

############################################################
################### Neo-Vim Text Editor ####################
############################################################
_alert_local 'Installing nvim'
./setup_nvim.sh || _alert_local "Nvim setup failed" 1

############################################################
###################### Alacritty ###########################
############################################################
_alert_local 'Installing alacritty'
./setup_alacritty.sh || _alert_local "Alacritty setup failed" 1

#############################################################
########## Other packages not available in apt ##############
#############################################################
# trash-d (replacement for rm to trash the files instead of actually deleting them)
_alert_local "Installing trash-d"
mkdir -p ~/softwares/trash-d
pushd ~/softwares/trash-d
curl -kLO https://github.com/rushsteve1/trash-d/releases/download/18/trash-d-18-x86_64.deb ||
    _alert_local "trash-d download failed!" 1
sudo dpkg -i ./trash-d-18-x86_64.deb || _alert_local "trash-d install failed!" 1
popd

# Fzf
_alert_local 'Installing Fzf'
git -C ~/.fzf pull || git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
if [ -f ~/.fzf/install ]; then
    ~/.fzf/install --all --no-bash
else
    _alert_local "Fzf installation failed" 1
fi

# lf - file manager
_alert_local "Installing lf"
curl -L https://github.com/gokcehan/lf/releases/latest/download/lf-linux-amd64.tar.gz | tar xzC ~/.local/bin

# marktext
_alert_local "Installing marktext markdown editor"
mkdir -p ~/softwares/marktext
pushd ~/softwares/marktext
curl -kLO https://github.com/marktext/marktext/releases/latest/download/marktext-amd64.deb
sudo dpkg -i ./marktext-amd64.deb || _alert_local "marktext install failed!" 1
popd

#############################################################
################### Flatpak Packages ########################
#############################################################
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

_alert_local "Run this and relaunch terminal 'chsh -s $(which zsh)'"
