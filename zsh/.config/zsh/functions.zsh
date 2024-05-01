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
function _fzf-cdprev-widget() {
    setopt localoptions pipefail no_aliases 2> /dev/null
    dir="$(dirs -p | fzf-tmux -p 85% --reverse --no-multi)"
    if [[ -z $dir ]]; then
        zle redisplay
        return 0
    fi
    zle push-line
    BUFFER="builtin cd -- $dir"
    zle accept-line
    local ret=$?
    unset dir
    zle reset-prompt
    return $ret
}
zle -N _fzf-cdprev-widget fzf-cdprev-widget
