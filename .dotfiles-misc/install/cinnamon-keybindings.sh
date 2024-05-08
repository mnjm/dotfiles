#!/usr/bin/env bash

source $HOME/.dotfiles-misc/install/setup_utils.sh

op=$1

case $op in
    dump) # To dump the keybinds to a file
        dconf dump /org/cinnamon/desktop/keybindings/ > cinnamon-keybindings ;;
    load) # To load the keybindings
        dconf load /org/cinnamon/desktop/keybindings/ < cinnamon-keybindings ;;
    *) _alert_local "Invalid option: either use dump or load" ;;
esac
