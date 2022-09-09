# Enable control-x-e to edit command in editor
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line

autoload -U add-zsh-hook

export DOTFILES="$HOME/workspace/dotfiles"

# Running alias
source ~/.zsh_alias

# Setting Up Zsh setops
setopt no_beep                  # No Beeps Please
setopt list_types               # List File Types in Completion
setopt hist_ignore_dups         # Ignore Duplicate Commands in Histroy File
setopt hist_verify
setopt hist_expire_dups_first   # Duplicates will be removed first
setopt extended_history         # Save start and elapsed time in history
setopt auto_pushd               # Use pushd instead of cd
setopt prompt_subst             # Enable prompt subsitution

# Setting up prompt
NEWLINE=$'\n'

# Load version control information
autoload -Uz vcs_info
precmd() { vcs_info }

# Format the vcs_info_msg_0_ variable to display git info
zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:*' check-for-changes true 
zstyle ':vcs_info:*' unstagedstr ' %F{red}%B❗%b%f'
zstyle ':vcs_info:*' stagedstr ' %F{yellow}%B✛%b%f'
zstyle ':vcs_info:git:*' formats '%F{119}↝  %b%f%c%u'
zstyle ':vcs_info:git:*' actionformats '%F{119}↝  %b%f performing %F{119}%a%f %c%u'
 
export PROMPT='${NEWLINE}%(?..%F{red}❌ )%F{14}%n@%m%f%F{white}:%F{green}%~ ${vcs_info_msg_0_} ${NEWLINE}%F{172}$ %f'

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Exports
export EDITOR=vim
export VISUAL=$EDITOR
export PATH=$PATH:$HOME/bin/
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
