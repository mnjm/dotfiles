# Setting Up Oh My Zsh
export ZSH="/home/mm/.oh-my-zsh"

ZSH_THEME="my_amuse"

plugins=(
  git
  extract
  python
  vi-mode
)

source $ZSH/oh-my-zsh.sh
source ~/.zsh_alias

# Setting Up Zsh
setopt no_beep                  # No Beeps Please
setopt rm_star_wait             # rm * will wait for 10secs
setopt list_types               # List File Types in Completion
setopt hist_ignore_dups         # Ignore Duplicate Commands in Histroy File
setopt hist_verify              # DONT KNOW
setopt hist_expire_dups_first   # Duplicates will be removed first
setopt extended_history         # Save start and elapsed time in history
setopt auto_pushd
