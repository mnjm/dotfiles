#!/usr/bin/env bash

# WARNING: This script is deprecated. Checkout https://github.com/alacritty/alacritty/blob/master/INSTALL.md

. $DOTFILES/install/setup_utils.sh


# Clone / Pull alacritty
take ~/softwares/alacritty
_git_clone_pull https://github.com/alacritty/alacritty.git .

# Install rust
_alert_local "Installing rust"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env
rustup override set stable
rustup update stable

# Build alacritty
_alert_local "Building alacritty"
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
# Autocompletions
mkdir -p ~/.zsh/zsh_functions/
cp extra/completions/_alacritty ~/.config/zsh/zsh_functions

popd

mkdir -p ~/.config/alacritty
# Download https://github.com/eendroroy/alacritty-theme
_git_clone_pull https://github.com/eendroroy/alacritty-theme.git ~/.config/alacritty/colorschemes
