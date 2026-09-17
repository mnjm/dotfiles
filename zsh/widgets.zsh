_fzf-cdprev-widget() {
  local selected
  local -a fzf_command=(fzf)

  if [[ -n $TMUX_PANE && -n $FZF_TMUX_OPTS && -n ${commands[fzf-tmux]} ]]; then
    fzf_command=(fzf-tmux ${(z)FZF_TMUX_OPTS} --)
  fi

  selected=$(dirs -p | command sed 1d | "${fzf_command[@]}" --reverse --no-multi) || return 0
  [[ -n $selected ]] || return 0

  builtin cd -- "$selected" || return
  zle reset-prompt
}

_lf-cd-widget() {
  local selected

  selected=$(lf -print-last-dir) || return 0
  [[ -d $selected && $selected != "$PWD" ]] || return 0

  builtin cd -- "$selected" || return
  zle reset-prompt
}

_lf-file-picker-widget() {
  local selected item

  selected=$(lf -print-selection) || return 0
  [[ -n $selected ]] || return 0

  while IFS= read -r item; do
    LBUFFER+="${(q)item} "
  done <<< "$selected"
  zle reset-prompt
}
