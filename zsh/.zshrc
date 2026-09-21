# Environment
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export EDITOR=nvim
export VISUAL=$EDITOR
export BROWSER=brave-browser
export HISTFILE="$HOME/.cache/zsh_history"
export HISTSIZE=10000
export SAVEHIST=10000
export CODEX_HOME="$XDG_CONFIG_HOME/codex"
export PI_CODING_AGENT_DIR="$XDG_CONFIG_HOME/pi/agent"
export VIRTUAL_ENV_DISABLE_PROMPT=1

# Machine-specific settings stay out of version control.
[[ -r "$ZDOTDIR/.zshrc_local" ]] && source "$ZDOTDIR/.zshrc_local"

# Keep existing PATH precedence and append these directories only once.
typeset -U path PATH
path+=("$XDG_CONFIG_HOME/bin" "$HOME/.local/bin")

# Commands
source "$ZDOTDIR/alias"

take() {
  mkdir -p -- "$1" && pushd -- "$1"
}

# Completion
fpath=("$ZDOTDIR/zsh_functions" "${fpath[@]}")
autoload -Uz compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit -d "$ZDOTDIR/.zcompdump"
_comp_options+=(globdots)

# History and navigation
setopt no_beep
setopt list_types
setopt hist_ignore_dups
setopt hist_verify
setopt hist_expire_dups_first
setopt extended_history
setopt auto_pushd
setopt pushd_ignore_dups
setopt prompt_subst
setopt auto_cd

# Prompt
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr ' %F{red}%B!%b%f'
zstyle ':vcs_info:*' stagedstr ' %F{yellow}%B+%b%f'
zstyle ':vcs_info:git:*' formats '%F{119}  %b%f%c%u %F{210}%m%f'
zstyle ':vcs_info:git:*' actionformats '%F{119}  %b%f performing %F{119}%a%f %c%u %F{210}%m%f'
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked

+vi-git-untracked() {
  if git status --porcelain 2>/dev/null | command grep -q '^??'; then
    hook_com[misc]='%B?%b'
  fi
}

precmd() {
  vcs_info
  if [[ -n $VIRTUAL_ENV ]]; then
    prompt_venv="%F{33}[ ${VIRTUAL_ENV:t}]%f"
  else
    prompt_venv=''
  fi
}

NEWLINE=$'\n'
PROMPT='${NEWLINE}%F{14}%n%f%F{white}@%f%F{202}%m%f%F{white}:%f%F{green}%~ ${vcs_info_msg_0_} ${prompt_venv}${NEWLINE}%(?.%F{172}$.%F{red}X) %f'

# fzf
if (( $+commands[fzf] )); then
  if (( $+commands[fzf-tmux] )); then
    export FZF_TMUX_OPTS='-p 85%'
  else
    unset FZF_TMUX_OPTS
  fi

  if (( $+commands[fd] )); then
    export FZF_CTRL_T_COMMAND="fd -H --exclude '**/.git/'"
    export FZF_ALT_C_COMMAND="fd -t d -H --exclude '**/.git/'"
  fi

  export FZF_DEFAULT_OPTS='--height 50% --layout=reverse --border'
  if (( $+commands[bat] )); then
    export FZF_CTRL_T_OPTS="--preview='bat --style=numbers --color=always --line-range :500 {}'"
  fi

  [[ -r "$ZDOTDIR/fzf.zsh" ]] && source "$ZDOTDIR/fzf.zsh"
  bindkey '^t' undefined-key
  bindkey '\ec' undefined-key
  zle -N _fzf-cdprev-widget
  bindkey '^o' fzf-cd-widget
  bindkey '^f' fzf-file-widget
  bindkey '^\' _fzf-cdprev-widget
fi

# lf widgets
if (( $+commands[lf] )); then
  source "$ZDOTDIR/widgets.zsh"
  zle -N _lf-cd-widget
  zle -N _lf-file-picker-widget
  bindkey '^x^o' _lf-cd-widget
  bindkey '^x^f' _lf-file-picker-widget
fi

# Editing and terminal keys
bindkey -e
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^e' edit-command-line

WORDCHARS='*?_-.[]~=&;!#$%^(){}<>' # These characters count as part of a word for word-wise editing.

# Plugins
if [[ -r "$ZDOTDIR/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
  source "$ZDOTDIR/zsh-autosuggestions/zsh-autosuggestions.zsh"
  bindkey -M menuselect '^[[Z' reverse-menu-complete
  bindkey '^ ' autosuggest-accept
fi

# zsh-syntax-highlighting must load after all widgets and bindings.
[[ -r "$ZDOTDIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]] && \
  source "$ZDOTDIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
