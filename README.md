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
sudo apt install git
git clone https://github.com/mnjm/dotfiles.git
export DOTFILES=$PWD/dotfiles
cd dotfiles/install
./install_dotfiles.sh # to install dotfiles
./install_apps.sh # to install apps
```

## Screenshots

### NeoVim

![NeoVim](https://github.com/mnjm/github-media-repo/blob/042d8b324ca4d03228d31cb0cbac69248a2eb860/dotfiles/neovim.png)

**Plugins**

    - Theme : [PaperColor-Slim](https://github.com/pappasam/papercolor-theme-slim)

    - Statusline : [bottomline.nvim](https://github.com/bottomline.nvim)

    - Tabline : [topline.nvim](https://github.com/topline.nvim)

### Zsh Prompt

![Zsh-Prompt](https://github.com/mnjm/dotfiles/blob/assets/zsh_prompt.png?raw=true)

Minimal with [syntax highlighting](https://github.com/zsh-users/zsh-syntax-highlighting), [autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) and git info

### TMUX

![TMUX](https://github.com/mnjm/github-media-repo/blob/163033571c59e35cce19bade50af007aa9fbb217/dotfiles/tmux.jpg)
