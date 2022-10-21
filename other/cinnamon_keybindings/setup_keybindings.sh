#!/usr/bin/env bash

# To dump the keybinds to a file
# dconf dump /org/cinnamon/desktop/keybindings/ > cinnamon_keybindings

# To load the keybindings
dconf load /org/cinnamon/desktop/keybindings/ < cinnamon_keybindings
