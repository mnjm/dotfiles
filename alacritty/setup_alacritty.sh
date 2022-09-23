#!/usr/bin/env bash

# WARNING: This script is deprecated. Checkout https://github.com/alacritty/alacritty/blob/master/INSTALL.md

. $DOTFILES/setup_utils.sh


# Clone / Pull alacritty
mkdir -p ~/softwares
git -C ~/softwares/alacritty pull || git clone https://github.com/alacritty/alacritty.git ~/softwares/alacritty

pushd ~/softwares/alacritty

# Install alacritty
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env
rustup override set stable
rustup update stable
# Install dependencies
sudo apt install cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3 -y
cargo build --release
# Terminfo for alacritty
sudo tic -xe alacritty,alacritty-direct extra/alacritty.info
# Desktop Entry
sudo cp target/release/alacritty /usr/local/bin # or anywhere else in $PATH
sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
sudo desktop-file-install extra/linux/Alacritty.desktop
sudo update-desktop-database
# Manuals
sudo mkdir -p /usr/local/share/man/man1
gzip -c extra/alacritty.man | sudo tee /usr/local/share/man/man1/alacritty.1.gz > /dev/null
gzip -c extra/alacritty-msg.man | sudo tee /usr/local/share/man/man1/alacritty-msg.1.gz > /dev/null

popd

mkdir -p ~/.zsh/zsh_functions/
cp extra/completions/_alacritty ~/.zsh/zsh_functions
_alert_local "Add 'fpath+=~/.zsh/zsh_functions' line into ur zshrc_local (~/.zshrc_local)"

mkdir -p ~/.config/alacritty
ln -vs $DOTFILES/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml || ls -l ~/.config/alacritty/alacritty.yml
