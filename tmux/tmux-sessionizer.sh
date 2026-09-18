#!/usr/bin/env zsh

typeset current_session selected kind name display_name project_path project_dir
typeset -a entries
typeset dir_icon="  "
typeset workspace_icon="  "

if [[ -n $TMUX ]]; then
  current_session=$(tmux display-message -p '#S')
fi

while IFS= read -r name; do
  [[ -z $name || $name == _* || $name == $current_session ]] && continue
  entries+=("session"$'\t'"$name"$'\t'"$workspace_icon$name")
done < <(tmux list-sessions -F '#S' 2>/dev/null)

for project_dir in "$HOME/work" "$HOME/personal"; do
  [[ -d $project_dir ]] || continue

  for project_path in "$project_dir"/*(/N); do
    name="${project_dir:t}/${project_path:t}"
    tmux has-session -t "$name" 2>/dev/null || entries+=("project"$'\t'"$name"$'\t'"$dir_icon$name"$'\t'"$project_path")
  done
done

(( $#entries )) || exit 0

selected=$(printf '%s\n' "${entries[@]}" | fzf --reverse --no-multi \
  --delimiter=$'\t' --with-nth=3)
[[ -n $selected ]] || exit 0

IFS=$'\t' read -r kind name display_name project_path <<< "$selected"

if [[ -z $TMUX ]]; then
  if [[ $kind == project ]]; then
    tmux new-session -A -s "$name" -c "$project_path"
  else
    tmux new-session -A -s "$name"
  fi
elif ! tmux has-session -t "$name" 2>/dev/null; then
  tmux new-session -d -s "$name" -c "$project_path"
  tmux switch-client -t "$name"
else
  tmux switch-client -t "$name"
fi
