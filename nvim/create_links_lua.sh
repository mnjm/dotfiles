#!/usr/bin/env bash

. $DOTFILES/setup_utils.sh

# remove broken symlinks
find -L ~/.config/nvim -type l -exec rm -v -- {} +

# make links
from="${DOTFILES}/nvim"
to="${HOME}/.config/nvim"
cfiles=$(find $from -name "*.lua")

for srcfile in $cfiles; do
    dstfile="${srcfile/$from/$to}"
    bdir=$(dirname $dstfile)
    mkdir -vp $bdir
    _link_file $srcfile $dstfile
done
