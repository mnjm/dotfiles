#!/usr/bin/env bash

source $HOME/.dotfiles/install/setup_utils.sh

op=$1
dconf="/org/cinnamon/desktop/keybinds/"
kb_file="$HOME/.dotfiles/install/cinnamon-keybindings"

case $op in
    save) # To dump the keybinds to a file
        dconf dump /org/cinnamon/desktop/keybindings/ > $kb_file;;
    install) # To load the keybindings
        dconf load  /org/cinnamon/desktop/keybindigs/ < $kb_file;;
    *)
        _alert_local "Invalid option: either pass either 'save' or 'install'" 1
        exit 1;;
esac
