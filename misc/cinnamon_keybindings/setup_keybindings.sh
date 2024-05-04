#!/usr/bin/env bash

source $DOTFILES/install/setup_utils.sh

op=$1

case $op in
    dump) # To dump the keybinds to a file
        dconf dump /org/cinnamon/desktop/keybindings/ > cinnamon_keybindings ;;
    load) # To load the keybindings
        dconf load /org/cinnamon/desktop/keybindings/ < cinnamon_keybindings ;;
    *) _alert_local "Invalid option: either use dump or load" ;;
esac
