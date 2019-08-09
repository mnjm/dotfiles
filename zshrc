# Editor
export EDITOR=vim
export VISUAL=$EDITOR

# Enable control-x-e to edit command in editor
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line

export DOTFILES="$HOME/Workspace/dotfiles"

# Setting Up Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="my_amuse"

plugins=(
  git
  extract
  python
  virtualenv
)

source $ZSH/oh-my-zsh.sh
source ~/.zsh_alias

# Setting Up Zsh
setopt no_beep                  # No Beeps Please
setopt list_types               # List File Types in Completion
setopt hist_ignore_dups         # Ignore Duplicate Commands in Histroy File
setopt hist_verify              # DONT KNOW
setopt hist_expire_dups_first   # Duplicates will be removed first
setopt extended_history         # Save start and elapsed time in history
setopt auto_pushd               # Use pushd instead of cd

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
