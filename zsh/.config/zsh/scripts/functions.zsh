# Safe Remove
function safe_rm() {
    _alert_local 'Moving files to Trash. To use rm, Use \\rm instead of rm to bypass alias'
    trash -vI "$@"
}

# Open clipboard through vim
function vclip() {
    tmp="/tmp/clipboard"
    # Copy clipboard to the temp file
    xclip -selection clipboard -o > $tmp
    # Call vim to edit
    $EDITOR $tmp
    # Move contents back to clipboard
    cat $tmp | xclip -selection clipboard -i
    # Trap to remove temp file when system shutdown
    trap 'rm -f $tmp >/dev/null 2>&1' HUP INT QUIT TERM PWR EXIT
}

# Use lf to switch directories
function lfcd() {
    tmp="$(mktemp -uq)"
    trap 'rm -f $tmp >/dev/null 2>&1' HUP INT QUIT TERM PWR EXIT
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
} 

# git diff previewer tool.
function git_diff_previewer() {
    gdir=$(git rev-parse --git-dir 2>/dev/null | wc -l)
    if [ $gdir -eq 0 ]; then
        _alert_local "Not in a git repo" 1
        return 1
    fi
    # uses fzf and delta
    previewer="git diff $@ --color=always -- {-1} | delta"
    selected=$(git diff $@ --name-only | fzf --height 100% -m --ansi --preview $previewer --preview-window top,90%,border-bottom)
    git diff $@ --color=always -- $selected
}

# help
function help() {
    man "$@" || "$@" --help 2>&1 | bat --plain --language=help
}
