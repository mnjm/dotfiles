#!/usr/bin/env bash

. $DOTFILES/setup_utils.sh

mkdir -p ~/softwares/lua-language-server
pushd ~/softwares/lua-language-server
curl -L https://github.com/sumneko/lua-language-server/releases/download/3.5.6/lua-language-server-3.5.6-linux-x64.tar.gz | tar xz
_link_file ./bin/lua-language-server ~/.local/bin/lua-language-server
popd
