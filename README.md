# mnjm-dotfiles

Includes my configurations files for

- [neovim](https://github.com/mnjm/dotfiles/tree/main/nvim/.config/nvim)
- [zsh](https://github.com/mnjm/dotfiles/tree/main/zsh/.config/zsh)
- [vim](https://github.com/mnjm/dotfiles/blob/main/vim/.vimrc) - vanilla config with some niceties for fallback in case my neovim config breaks
- [alacritt](https://github.com/mnjm/dotfiles/tree/main/alacritty/.config/alacritty)
- [tmux](https://github.com/mnjm/dotfiles/blob/main/tmux/.tmux.conf)
- a few handy shell [scripts](https://github.com/mnjm/dotfiles/tree/main/scripts/.local/bin)

# Installation

```bash
sudo apt install git -y
git clone --bare git@github.com:mnjm/dotfiles.git $HOME/.dotfiles-git
echo ".dotfiles-git" >> ~/.dotfiles-git/info/exclude
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles-git/ --work-tree=$HOME'
config checkout
```

# App Installer

```bash
$HOME/.dotfiles-misc/install/install_apps.sh
```
# Cinnamon Keybindings Installer

```bash
$HOME/.dotfiles-misc/install/cinnamon-keybindings.sh  load
```

# Screenshots

## NeoVim

![NeoVim](https://github.com/mnjm/github-media-repo/blob/main/dotfiles/neovim.png?raw=true)

Colorscheme - [onedarkpro.nvim](https://github.com/olimorris/onedarkpro.nvim)

### Plugins
- Statusline - [bottomline.nvim](https://github.com/mnjm/bottomline.nvim)
- Tabline - [topline.nvim](https://github.com/mnjm/topline.nvim)
- WinLine - [winline.nvim](https://github.com/mnjm/winline.nvim)

## Zsh Prompt

![Zsh-Prompt](https://github.com/mnjm/github-media-repo/blob/main/dotfiles/zsh_prompt.png?raw=true)

Minimal with [syntax highlighting](https://github.com/zsh-users/zsh-syntax-highlighting), [autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) and git info

## TMUX

![TMUX](https://github.com/mnjm/github-media-repo/blob/main/dotfiles/tmux.jpg?raw=true)
