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

function _lf-cd-widget() {
    local ret=0
    setopt localoptions pipefail no_aliases 2> /dev/null
    local selected="$(lf -print-last-dir)"
    # handle names with spaces
    if [ -d "$selected" ] && [ "$selected" != "$(pwd)" ]; then
        # cd command
        BUFFER="builtin cd -- ${(q)selected}"
        zle accept-line
        ret=$?
        zle reset-prompt
    else
        zle redisplay
    fi
    return $ret
}

# lf file picker
function __lf-file-picker-widget() {
    setopt localoptions pipefail no_aliases 2> /dev/null
    local selected="$(lf -print-selection)"
    # convert to single line
    if [ ! -z $selected ]; then
        echo $selected | while read item; do
            echo -n "${(q)item} "
        done
        echo
    fi
    return $?
}

function _lf-file-picker-widget() {
    LBUFFER="${LBUFFER}$(__lf-file-picker-widget)"
    local ret=$?
    zle reset-prompt
    return $ret
}
