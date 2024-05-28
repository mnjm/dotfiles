# mnjm-dotfiles

This repository contains configuration files for:

- [NeoVim](https://github.com/mnjm/dotfiles/tree/main/.config/nvim)
- [Zsh Shell](https://github.com/mnjm/dotfiles/tree/main/.config/zsh)
- [Vim](https://github.com/mnjm/dotfiles/blob/main/.vimrc) - a vanilla config with additional settings for fallback
- [Alacritty](https://github.com/mnjm/dotfiles/tree/main/.config/alacritty)
- [Tmux](https://github.com/mnjm/dotfiles/blob/main/.config/tmux/tmux.conf)
- [i3wm](https://github.com/mnjm/dotfiles/blob/main/.config/i3/config)
- Useful shell [scripts](https://github.com/mnjm/dotfiles/tree/main/.local/bin)
- Application installation [scripts](https://github.com/mnjm/dotfiles/tree/main/.dotfiles/install) (for Debian-based systems like Ubuntu and Mint)

## Installation

```bash
sudo apt install git -y
git clone --bare git@github.com:mnjm/dotfiles.git $HOME/.dotfiles.git
echo ".dotfiles.git" >> ~/.dotfiles-git/info/exclude
alias dotgit='/usr/bin/git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME'
dotgit config --local status.showUntrackedFiles no
dotgit checkout
```

### Application Installer

```bash
$HOME/.dotfiles/install/install_apps.sh
```

### Cinnamon Keybindings Installer

```bash
$HOME/.dotfiles/install/cinnamon-keybindings.sh install
```

## Screenshots

### NeoVim

![NeoVim](https://github.com/mnjm/github-media-repo/blob/main/dotfiles/neovim.png?raw=true)

Color scheme - [onedarkpro.nvim](https://github.com/olimorris/onedarkpro.nvim)

#### Plugins
- Statusline - [bottomline.nvim](https://github.com/mnjm/bottomline.nvim)
- Tabline - [topline.nvim](https://github.com/mnjm/topline.nvim)
- WinLine - [winline.nvim](https://github.com/mnjm/winline.nvim)

### Zsh Prompt

![Zsh Prompt](https://github.com/mnjm/github-media-repo/blob/main/dotfiles/zsh_prompt.png?raw=true)

Minimal prompt with [syntax highlighting](https://github.com/zsh-users/zsh-syntax-highlighting), [autosuggestions](https://github.com/zsh-users/zsh-autosuggestions), and git info.

### TMUX

![TMUX](https://github.com/mnjm/github-media-repo/blob/main/dotfiles/tmux.jpg?raw=true)
