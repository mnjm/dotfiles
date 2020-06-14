# Editor
export EDITOR=vim
export VISUAL=$EDITOR
export PATH=$PATH:$HOME/bin/

# Enable control-x-e to edit command in editor
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line

# Enable auto ls after every cd.
# autoload -U add-zsh-hook
# add-zsh-hook -Uz chpwd (){ ls --color=always; }

export DOTFILES="$HOME/Workspace/dotfiles"

# Setting Up Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="my_amuse"

function highlight() {
	declare -A fg_color_map
	fg_color_map[black]=30
	fg_color_map[red]=31
	fg_color_map[green]=32
	fg_color_map[yellow]=33
	fg_color_map[blue]=34
	fg_color_map[magenta]=35
	fg_color_map[cyan]=36
	 
	fg_c=$(echo -e "\e[1;${fg_color_map[$1]}m")
	c_rs=$'\e[0m'
	sed -u s"/$2/$fg_c\0$c_rs/g"
}

plugins=(
  git
  extract
  python
  virtualenv
  colored-man-pages
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
export PATH=/usr/local/cuda-10.1/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=/usr/local/cuda-10.1/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
