#!/usr/bin/env bash

. $DOTFILES/setup_utils.sh

_link_file $DOTFILES/tmux/tmux.conf ~/.tmux.conf
# Tmux Plugin Manager
_alert_local 'Setting up Tmux Plugin Manager'
mkdir -p ~/.tmux
_git_clone_pull https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
_alert_local 'Installing tmux plugins'
if [ -f ~/.tmux/plugins/tpm/tpm ]  && [ -f ~/.tmux/plugins/tpm/bin/install_plugins ]; then
    ~/.tmux/plugins/tpm/tpm
    export TMUX_PLUGIN_MANAGER_PATH=$HOME/.tmux/plugins
    ~/.tmux/plugins/tpm/bin/install_plugins
else
    _alert_local "Tpm installation failed" 1
fi
