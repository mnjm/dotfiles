#!/usr/bin/env zsh

typeset selected kind title display_name target project_dir project_path workspace_id workspace_name workspace_path
typeset -a entries
typeset -A seen_titles
typeset dir_icon="  "
typeset workspace_icon="  "

project_title() {
  local path=$1 root

  path=${path:A}
  for root in "$HOME/work" "$HOME/personal" "$HOME/workspace"; do
    [[ -d $root && $path == "${root:A}"/* ]] || continue
    print -r -- "${root:t}/${path#${root:A}/}"
    return
  done
}

while IFS=$'\t' read -r workspace_id workspace_name; do
  [[ -n $workspace_id ]] || continue

  workspace_path=$(herdr workspace get "$workspace_id" 2>/dev/null | jq -r '
    (.result.workspace // .workspace // .result // .) as $workspace
    | ($workspace.cwd // $workspace.identity_cwd // $workspace.root_pane.cwd // empty)
  ')
  title=$(project_title "$workspace_path")
  [[ -n $title ]] || title=$workspace_name
  [[ -n $title ]] || title=$workspace_id
  [[ -n ${seen_titles[$title]} ]] && continue

  seen_titles[$title]=1
  entries+=("workspace"$'\t'"$title"$'\t'"$workspace_icon$title"$'\t'"$workspace_id")
done < <(
  herdr workspace list | jq -r '
    (.result.workspaces // .workspaces // [])[]
    | [.workspace_id // .id, (.label // .name // .custom_name // "")]
    | @tsv
  '
)

for project_dir in "$HOME/work" "$HOME/personal"; do
  [[ -d $project_dir ]] || continue

  for project_path in "$project_dir"/*(/N); do
    title="${project_dir:t}/${project_path:t}"
    [[ -n ${seen_titles[$title]} ]] && continue

    seen_titles[$title]=1
    entries+=("project"$'\t'"$title"$'\t'"$dir_icon$title"$'\t'"$project_path")
  done
done

(( $#entries )) || exit 0

selected=$(printf '%s\n' "${entries[@]}" | fzf --reverse --no-multi \
  --delimiter=$'\t' --with-nth=3)
[[ -n $selected ]] || exit 0

IFS=$'\t' read -r kind title display_name target <<< "$selected"

if [[ $kind == workspace ]]; then
  herdr workspace focus "$target"
else
  herdr workspace create --cwd "$target" --label "$title" --focus
fi
