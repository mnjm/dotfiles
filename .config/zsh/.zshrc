#
# ███████╗███████╗██╗  ██╗██████╗  ██████╗
# ╚══███╔╝██╔════╝██║  ██║██╔══██╗██╔════╝
#   ███╔╝ ███████╗███████║██████╔╝██║
#  ███╔╝  ╚════██║██╔══██║██╔══██╗██║
# ███████╗███████║██║  ██║██║  ██║╚██████╗
# ╚══════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝

# Exports
export XDG_CONFIG_HOME=$HOME/.config
export EDITOR=nvim
export VISUAL=$EDITOR
export BROWSER=brave-browser
export LC_ALL=en_IN.UTF-8
export LANG=en_IN.UTF-8
export TERM="xterm-256color"
export HISTFILE=~/.cache/zsh_history
export HISTSIZE=10000
export SAVEHIST=10000
export MANPAGER='nvim --appimage-extract-and-run +Man!'
export FZF_TMUX_OPTS="-p 85%"
export FZF_CTRL_T_COMMAND="fdfind -H --exclude '**/.git/'"
export FZF_ALT_C_COMMAND="fdfind -t d -H --exclude '**/.git/'"
export FZF_DEFAULT_OPTS='--height 50% --layout=reverse --border'
export FZF_CTRL_T_OPTS="--preview='bat --style=numbers --color=always --line-range :500 {}'"

# disable default python virtualenv prompt display
export VIRTUAL_ENV_DISABLE_PROMPT=1

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
if [ -d "$PYENV_ROOT" ]; then
    command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi

# NOTE: System Specific exports [Not tracked in dotfiles]
zshrclcl=$HOME/.config/zsh/.zshrc_local
[ -f "$zshrclcl" ] && . $zshrclcl

source $HOME/.dotfiles/install/setup_utils.sh
_source_if_file_exists_err $HOME/.config/zsh/alias

# Update $PATH
_path_add $HOME/.local/bin
_path_add $HOME/.cargo/bin

# Load zsh_functions
fpath+=~/.config/zsh/zsh_functions

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

# Load version control information to display it in prompt
autoload -Uz vcs_info
precmd() { vcs_info }

# Format the vcs_info_msg_0_ variable to display git info
zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr ' %F{red}%B!%b%f'
zstyle ':vcs_info:*' stagedstr ' %F{yellow}%B+%b%f'
zstyle ':vcs_info:git:*' formats '%F{119}  %b%f%c%u %F{210}%m%f'
zstyle ':vcs_info:git:*' actionformats '%F{119}  %b%f performing %F{119}%a%f %c%u %F{210}%m%f'
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
+vi-git-untracked() {
  if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
     git status --porcelain | grep -m 1 '^??' &>/dev/null
  then
    hook_com[misc]='%B?%b'
  fi
}

# pyenv prompt
function py_venv_hook() {
  if [[ ! -z "$VIRTUAL_ENV" ]];
  then
    py_venv="%F{33}[ ${VIRTUAL_ENV##*/}]%f"
  else
    py_venv=""
  fi
  echo -e "$py_venv"
}

# Setting up prompt
NEWLINE=$'\n'
export PROMPT='${NEWLINE}%(?..%F{red} )%F{14}%n%f%F{white}@%f%F{202}%m%f%F{white}:%f%F{green}%~ ${vcs_info_msg_0_} $(py_venv_hook)${NEWLINE}%F{172}$ %f'

# Highlight completions
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)   # Include hidden files.

# Zsh Plugins
# auto suggestions
_source_if_file_exists_err ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
# syntax highlighting
_source_if_file_exists_err ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# widgets
_source_if_file_exists_err $HOME/.config/zsh/widgets.zsh
# fzf
_source_if_file_exists_err ~/.fzf.zsh

# completion and suggesion bindings
bindkey -M menuselect '^[[Z' reverse-menu-complete   # 'Shift-tab' to reverse through menu select
bindkey '^ ' autosuggest-accept                      # Ctrl+space to accept the suggestion

# Fzf bindings
bindkey '^t' undefined-key
bindkey '\ec' undefined-key
zle -N _fzf-cdprev-widget
bindkey '^o' fzf-cd-widget                           # ctrl+o to fzf-cd-widgetj
bindkey '^\' _fzf-cdprev-widget                      # ctrl+p to fzf-cdprev-widget
bindkey '^f' fzf-file-widget                         # bind ctrl+f to fzf-sel

# lf widgets - lfcd and lf file picker
zle -N _lf-cd-widget
zle -N _lf-file-picker-widget
bindkey '^x^o' _lf-cd-widget
bindkey '^x^f' _lf-file-picker-widget

# Enable control-e to edit command in editor
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^e' edit-command-line                       # Prefer opening vim rather than zsh's vi-mode

# some fixes when working with tmux
bindkey '^?' backward-delete-char                    # Fix somecases where backspace doenst work
bindkey  "^[[H"   beginning-of-line                  # alacritty + tmux fix
bindkey  "^[[F"   end-of-line
bindkey  "^[[3~"  delete-char
