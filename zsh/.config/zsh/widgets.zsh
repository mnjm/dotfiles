# cd previous using fzf
function _fzf-cdprev-widget() {
    setopt localoptions pipefail no_aliases 2> /dev/null
    dir="$(dirs -p | fzf-tmux -p 85% --reverse --no-multi)"
    if [[ -z $dir ]]; then
        zle redisplay
        return 0
    fi
    zle push-line
    dir=$(echo $dir | sed 's/ /\\ /g') # escape space
    BUFFER="builtin cd -- $dir"
    zle accept-line
    local ret=$?
    unset dir
    zle reset-prompt
    return $ret
}

# Use lf to switch directories lfcd
function _lfcd-widget() {
    local ret=0
    setopt localoptions pipefail no_aliases 2> /dev/null
    tmp="$(mktemp -uq)"
    trap 'rm -f $tmp >/dev/null 2>&1' HUP INT QUIT TERM PWR EXIT
    lf -last-dir-path="$tmp"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        if [ -d "$dir" ] && [ "$dir" != "$(pwd)" ]; then
            zle push-line
            dir=$(echo $dir | sed 's/ /\\ /g') # escape space
            BUFFER="builtin cd -- $dir"
            zle accept-line
            ret=$?
            unset dir
            zle reset-prompt
        else
            zle redisplay
        fi
    fi
    return $ret
} 
