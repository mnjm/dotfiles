#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

gopen() {
  case "$OSTYPE" in
    darwin*)  # macOS
      open "$@" ;;
    linux-gnu*|linux-musl*)
      if command -v xdg-open >/dev/null 2>&1; then
        xdg-open "$@" >/dev/null 2>&1 &
      elif command -v gio >/dev/null 2>&1; then
        gio open "$@" >/dev/null 2>&1 &
      elif grep -qi microsoft /proc/version 2>/dev/null; then
        # WSL (Windows Subsystem for Linux) — call explorer.exe with a Windows path.
        # explorer.exe accepts forward-slash URLs fine.
        explorer.exe "$@" >/dev/null 2>&1 &
      else
        echo "gopen: No graphical open command found (need xdg-open, gio, or explorer.exe)" >&2
        return 1
      fi
      ;;
    *)
      echo "gopen: Unsupported OS ($OSTYPE)" >&2
      return 1
      ;;
  esac
  return 0
}

include_branch=false
while getopts "b" opt; do
  case "$opt" in
    b) include_branch=true ;;
    *) echo "Usage: $(basename "$0") [-b]" >&2; exit 1 ;;
  esac
done
shift $((OPTIND -1))

link=$(git config --get remote.origin.url 2>/dev/null || true)
if [[ -z "$link" ]]; then
  echo "Not a git repo or no remote.origin.url configured." >&2
  exit 1
fi

if [[ "$link" =~ ^git@ ]]; then
  link="https://$(echo "$link" | sed -e 's/^git@//' -e 's/:/\//')"
fi

link=$(echo "$link" | sed -e 's/\.git$//')

if [[ "$include_branch" == true && "$link" == *github.com* ]]; then
  branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null || true)
  if [[ -n "$branch" && "$branch" != "HEAD" ]]; then
    link="${link}/tree/${branch}"
  fi
fi

printf 'Repo URL: %s\n' "$link"

printf 'Open in browser? [y/N]: '
IFS= read -r ans || ans=""

case "$ans" in
  [Yy]|[Yy][Ee][Ss])
    if [[ -n "${BROWSER:-}" ]]; then
      if command -v "${BROWSER%% *}" >/dev/null 2>&1; then
        sh -c "${BROWSER} \"$link\"" >/dev/null 2>&1 &
        disown
      else
        gopen "$link" || { echo "Failed to open link"; exit 1; }
      fi
    else
      gopen "$link" || { echo "Failed to open link"; exit 1; }
      disown
    fi
    ;;
  *)
    echo "Not opening."
    ;;
esac

exit 0
