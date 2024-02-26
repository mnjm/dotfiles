# dotfiles

Includes my configurations for

- zsh

- neovim

- vim - vanilla config with some niceties for fallback in case my neovim config breaks

- alacritty

- tmux

- and setup scripts to install packages I use frequently

### My Zsh Prompt

Minimal with [syntax highlighting](https://github.com/zsh-users/zsh-syntax-highlighting), [autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) and git info
![Zsh-Prompt](https://github.com/mnjm/dotfiles/blob/assets/zsh_prompt.png?raw=true)

Checkout my [.zshrc](https://github.com/mnjm/dotfiles/blob/master/zsh/zshrc)

Some custom scripts [here](https://github.com/mnjm/dotfiles/tree/63c199ce6afdda70aecc617dc95cd707c99cbad1/bin/dot-local/bin)

# Installation

```shell
sudo apt install git
git clone https://github.com/mnjm/dotfiles.git
export DOTFILES=$PWD/dotfiles
cd dotfiles/install
./install_dotfiles.sh # to install dotfiles
./install_apps.sh # to install apps
```
