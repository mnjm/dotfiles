#!/usr/bin/env bash

. $DOTFILES/install/setup_utils.sh

# Tmux Plugin Manager
_alert_local 'Setting up Tmux Plugin Manager'
mkdir -p ~/.tmux
_git_clone_pull https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
_alert_local 'Installing tmux plugins'
if [ ! -f ~/.tmux.conf ]; then
    _alert_local "~/.tmux.conf not found. Run setup_tmux.sh script after creating .tmux.conf file" 1
    exit 1
fi
if [ -f ~/.tmux/plugins/tpm/tpm ]  && [ -f ~/.tmux/plugins/tpm/bin/install_plugins ]; then
    ~/.tmux/plugins/tpm/tpm
    export TMUX_PLUGIN_MANAGER_PATH=$HOME/.tmux/plugins
    ~/.tmux/plugins/tpm/bin/install_plugins
else
    _alert_local "Tpm installation failed" 1
fi
