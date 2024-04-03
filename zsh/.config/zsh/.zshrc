# Exports
export EDITOR=nvim
export VISUAL=$EDITOR
export LC_ALL=en_IN.UTF-8
export LANG=en_IN.UTF-8
export TERM="xterm-256color"
export HISTFILE=~/.cache/zsh_history
export HISTSIZE=10000
export SAVEHIST=10000
export TMUX_PLUGIN_MANAGER_PATH=$HOME/.tmux/plugins
export LESS='-R'
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
export FZF_CTRL_T_OPTS="--preview='bat --style=numbers --color=always --line-range :500 {}'"
export MANROFFOPT="-c"

# System Specific exports. Alternatively these can be exported in ~/.zshrc_local file.
# Location where dotfiles cloned
export DOTFILES="$HOME/workspace/dotfiles"

# Loading local zshrc
zshrclcl="~/.zshrc_local"
[ -f "$zshrclcl" ] && source $zshrclcl

# Running scripts and alias
if [[ -v DOTFILES ]]; then
    source $DOTFILES/install/setup_utils.sh
    _source_if_file_exists_err $HOME/.config/zsh/functions.zsh
    _source_if_file_exists_err $HOME/.config/zsh/alias
else
    _alert_local "ERROR: \$DOTFILES not set. Cant load functions and aliases" 1
    exit
fi

# Update $PATH
_path_add $HOME/.local/bin
_path_add $HOME/.cargo/bin
_path_add /usr/local/go/bin

# Load zsh_functions
fpath+=~/.config/zsh/zsh_function

# Enable control-x-e to edit command in editor
autoload -U edit-command-line
zle -N edit-command-line

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
setopt auto_cd                  # perform a cd if cmd is a directory
setopt pushd_ignore_dups        # Ignore dupicates in pushd stack

# Setting up prompt
NEWLINE=$'\n'

# Load version control information
autoload -Uz vcs_info
precmd() { vcs_info }

# Format the vcs_info_msg_0_ variable to display git info
zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr ' %F{red}%B!%b%f'
zstyle ':vcs_info:*' stagedstr ' %F{yellow}%B+%b%f'
zstyle ':vcs_info:git:*' formats '%F{119}↝  %b%f%c%u %F{210}%m%f'
zstyle ':vcs_info:git:*' actionformats '%F{119}↝  %b%f performing %F{119}%a%f %c%u %F{210}%m%f'
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
+vi-git-untracked() {
  if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
     git status --porcelain | grep -m 1 '^??' &>/dev/null
  then
    hook_com[misc]='%B?%b'
  fi
}
export PROMPT='${NEWLINE}%(?..%F{red}X )%F{14}%n%f%F{white}@%f%F{202}%m%f%F{white}:%f%F{green}%~ ${vcs_info_msg_0_} ${NEWLINE}%F{172}$ %f'

# FZF
_source_if_file_exists_err ~/.fzf.zsh

# autojump
_source_if_file_exists /usr/share/autojump/autojump.sh

# pyenv
if [ -d "$PYENV_ROOT" ]; then
    eval "$(pyenv virtualenv-init -)"
fi

# Highlight completions
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# Zsh Plugins
_source_if_file_exists_err ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
_source_if_file_exists_err ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

bindkey '^ ' autosuggest-accept                      # Ctrl+space to accept the suggestion
bindkey -s '^b' '^ulfcd\n'                           # bind ctrl+b to lfcd
bindkey '^o' fzf-cd-widget                           # bind ctrl+o to fzf-cd
bindkey '^f' fzf-file-widget			     # bind ctrl+f to fzf-sel
bindkey '^e' edit-command-line                       # Prefer opening vim rather than zsh's vi-mode
bindkey '^?' backward-delete-char                    # Fix somecases where backspace doenst work
bindkey -M menuselect '^[[Z' reverse-menu-complete   # 'Shift-tab' to reverse through menu select
bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line
bindkey  "^[[3~"  delete-char

# run neofetch
if [[ $(who | wc -l) -eq 2 ]]; then
    macchina
fi
