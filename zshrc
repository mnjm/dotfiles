# Exports
export EDITOR=vim
export VISUAL=$EDITOR
export PATH=$PATH:$HOME/bin/
export PATH=$PATH:$HOME/.local/bin/
export LC_ALL=en_IN.UTF-8
export LANG=en_IN.UTF-8
export TERM=xterm-256color
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
export HISTFILE=~/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000
export DOTFILES="$HOME/workspace/dotfiles"

_alert_local() {
    color=${2:-6}
    tput setaf $color; echo $1; tput sgr0
}

_source_if_file_exists() {
    if [ -f "$1" ]; then
        source $1
    else
        _alert_local "File $1 doenst exists" 1
    fi
}

# Enable control-x-e to edit command in editor
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line # Prefer opening vim rather than zsh's vi-mode

autoload -U add-zsh-hook

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
zstyle ':vcs_info:git:*' formats '%F{119}↝  %b%f%c%u %F{210}%m%f'
zstyle ':vcs_info:git:*' actionformats '%F{119}↝  %b%f performing %F{119}%a%f %c%u %F{210}%m%f'
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
+vi-git-untracked() {
  if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
     git status --porcelain | grep -m 1 '^??' &>/dev/null
  then
    hook_com[misc]='%B⊛%b'
  fi
}
export PROMPT='${NEWLINE}%(?..%F{red}❌ )%F{14}%n%f%F{white}@%f%F{202}%m%f%F{white}:%f%F{green}%~ ${vcs_info_msg_0_} ${NEWLINE}%F{172}$ %f'

# FZF
_source_if_file_exists ~/.fzf.zsh

# Zsh Plugins
_source_if_file_exists ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '^ ' autosuggest-accept # Ctrl+space to accept the suggestion
_source_if_file_exists ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Running scripts
for sh_file in $DOTFILES/scripts/*.zsh; do
    source $sh_file
done
# Running alias
source ~/.zsh_alias
