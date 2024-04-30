# Safe Remove
function safe_rm() {
    _alert_local 'Moving files to Trash. To use rm, Use \\rm instead of rm to bypass alias'
    trash -vI "$@"
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

# help
function help() {
    man "$@" || "$@" --help 2>&1 | bat --plain --language=help
}

# cd previous
function cdp() {
    selected="$(dirs -v | sed 's/\s/:/' | fzf -d: --with-nth 2.. --reverse --no-multi)"
    if [[ -n $selected ]]; then
        cd "+$(echo $selected | cut -d: -f1)"
    fi
}
