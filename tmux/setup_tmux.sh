#!/bin/sh

ln -s tmux/tmux.conf ~/.tmux.conf
# Tmux Plugin Manager
alert_local 'Setting up Tmux Plugin Manager'
mkdir -p ~/.tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
alert_local 'Installing tmux plugins'
if [ -f ~/.tmux/plugins/tpm/tpm ]  && [ -f ~/.tmux/plugins/tpm/bin/install_plugins ]; then
    ~/.tmux/plugins/tpm/tpm
    export TMUX_PLUGIN_MANAGER_PATH=$HOME/.tmux/plugins/tpm
    ~/.tmux/plugins/tpm/bin/install_plugins
else
    alert_local "Tpm installation failed" 1
fi
