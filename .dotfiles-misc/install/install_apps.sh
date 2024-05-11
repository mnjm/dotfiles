#!/usr/bin/env bash

export DOTFILES=$PWD

. $HOME/.dotfiles-misc/install/setup_utils.sh

# Apt + Pip packages
_alert_local "Installing apt packages"
sudo apt install nala -y
xargs -a apt-packages.list sudo nala install -y
_alert_local "Installing pip packages"
xargs -a pip-packages.list python3 -m pip install --user

# Nerd Font
_alert_local "Installing Nerd Fonts"
mkdir -p ~/.fonts
curl -kL https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.2/UbuntuMono.zip -o /tmp/UbuntuMono.zip
unzip /tmp/UbuntuMono.zip -d "$HOME/.fonts/UbuntuMono"
fc-cache -fv || _alert_local "Fonts install failed" 1
rm /tmp/UbuntuMono.zip

# VIM Text Editor
_alert_local 'Setting Up Vim'
./vim.sh || _alert_local "Vim setup failed" 1

# ZSH Shell
_alert_local 'Setting Up Zsh'
./zsh.sh || _alert_local "Zsh setup failed" 1

# Neo-Vim Text Editor
_alert_local 'Installing nvim'
./nvim.sh || _alert_local "Nvim setup failed" 1

# Rust Install
_alert_local "Installing rust"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env
rustup override set stable
rustup update stable

# Pyenv
_alert_local "Installing pyenv"
curl https://pyenv.run | bash

# Alacritty
_alert_local 'Installing alacritty'
./alacritty.sh || _alert_local "Alacritty setup failed" 1

# Go
_alert_local "Installing go"
rm -rf ~/softwares/go && curl -L https://go.dev/dl/go1.22.2.linux-amd64.tar.gz | tar xzC ~/softwares
_link_file ~/softwares/go/bin/go ~/.local/bin/go
_link_file ~/softwares/go/bin/gofmt ~/.local/bin/gofmt

# trash-d (replacement for rm to trash the files instead of actually deleting them)
_alert_local "Installing trash-d"
_download_install_deb trash-d https://github.com/rushsteve1/trash-d/releases/download/19/trash-d-19-x86_64.deb

# Fzf
_alert_local 'Installing Fzf'
git -C ~/.fzf pull || git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
if [ -f ~/.fzf/install ]; then
    ~/.fzf/install --all --no-bash
else
    _alert_local "Fzf installation failed" 1
fi

# bat - alternative to cat
_alert_local "Installing bat"
_download_install_deb bat https://github.com/sharkdp/bat/releases/download/v0.24.0/bat-musl_0.24.0_amd64.deb

# lf - file manager
_alert_local "Installing lf"
curl -L https://github.com/gokcehan/lf/releases/latest/download/lf-linux-amd64.tar.gz | tar xzC ~/.local/bin

# obisidian
# _alert_local "Installing obisidian"
# _download_install_deb obsidian https://github.com/obsidianmd/obsidian-releases/releases/download/v1.0.0/obsidian_1.0.0_amd64.deb

_alert_local "Installing joplin"
wget -O - https://raw.githubusercontent.com/laurent22/joplin/dev/Joplin_install_and_update.sh | bash
_link_file ~/.joplin/Joplin.AppImage ~/.local/bin/joplin

# git-delta
_alert_local "Installing git-delta"
_download_install_deb git-delta https://github.com/dandavison/delta/releases/download/0.17.0/git-delta_0.17.0_amd64.deb

# fastfetch
_alert_local "Installing fastfetch"
_download_install_deb fastfetch https://github.com/fastfetch-cli/fastfetch/releases/download/2.9.1/fastfetch-linux-amd64.deb

#############################################################
################### Flatpak Packages ########################
#############################################################
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

_alert_local "Run this and relaunch terminal 'chsh -s $(which zsh)'"
