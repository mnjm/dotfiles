#!/usr/bin/env bash

# Checkout https://github.com/alacritty/alacritty/blob/master/INSTALL.md if it doesnt work

. $HOME/.dotfiles-misc/install/setup_utils.sh


# Clone / Pull alacritty
take ~/softwares/alacritty
_git_clone_pull https://github.com/alacritty/alacritty.git .

# Build alacritty
_alert_local "Building alacritty"
cargo build --release --no-default-features --features=x11

# Terminfo for alacritty
infocmp alacritty | sudo tic -xe alacritty,alacritty-direct extra/alacritty.info

# Desktop Entry
_link_file target/release/alacritty ~/.local/bin/ # or anywhere else in $PATH
sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
sudo desktop-file-install extra/linux/Alacritty.desktop
sudo update-desktop-database

# Manuals
sudo mkdir -p /usr/local/share/man/man1
sudo mkdir -p /usr/local/share/man/man5
scdoc < extra/man/alacritty.1.scd | gzip -c | sudo tee /usr/local/share/man/man1/alacritty.1.gz > /dev/null
scdoc < extra/man/alacritty-msg.1.scd | gzip -c | sudo tee /usr/local/share/man/man1/alacritty-msg.1.gz > /dev/null
scdoc < extra/man/alacritty.5.scd | gzip -c | sudo tee /usr/local/share/man/man5/alacritty.5.gz > /dev/null
scdoc < extra/man/alacritty-bindings.5.scd | gzip -c | sudo tee /usr/local/share/man/man5/alacritty-bindings.5.gz > /dev/null

# Autocompletions
mkdir -p ~/.config/zsh/zsh_functions/
cp extra/completions/_alacritty ~/.config/zsh/zsh_functions/

popd

mkdir -p ~/.config/alacritty
