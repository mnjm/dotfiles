#!/usr/bin/env bash

. $DOTFILES/setup_utils.sh

# Download lf bin
curl -L https://github.com/gokcehan/lf/releases/latest/download/lf-linux-amd64.tar.gz | tar xzC ~/.local/bin

mkdir -p ~/.config/lf
_link_file $DOTFILES/lf/lfrc ~/.config/lf/lfrc
_link_file $DOTFILES/lf/icons ~/.config/lf/icons
