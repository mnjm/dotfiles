# cd previous using fzf
function _fzf-cdprev-widget() {
    setopt localoptions pipefail no_aliases 2> /dev/null
    dir="$(dirs -p | fzf-tmux -p 85% --reverse --no-multi)"
    if [[ -z $dir ]]; then
        zle redisplay
        return 0
    fi
    # save the command line so it can be update after cd
    zle push-line
    # Modify the buffer with cd
    dir=$(echo $dir | sed 's/ /\\ /g') # escape space if any
    BUFFER="builtin cd -- $dir"
    # exec BUFFER
    zle accept-line
    local ret=$?
    unset dir
    # reset to saved line
    zle reset-prompt
    return $ret
}

# lfcd as widget
function _lf-cd-widget() {
    local ret=0
    setopt localoptions pipefail no_aliases 2> /dev/null
    # execute lf
    local selected="$(lf -print-last-dir)"
    # skip pwd
    if [ -d "$selected" ] && [ "$selected" != "$(pwd)" ]; then
        # save the line
        zle push-line
        BUFFER="builtin cd -- ${(q)selected}"
        # exec cd
        zle accept-line
        ret=$?
        # reset to saved line
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
    # single line output
    if [ ! -z $selected ]; then
        echo $selected | while read item; do
            echo -n "${(q)item} "
        done
    fi
    return $?
}

function _lf-file-picker-widget() {
    # call __lf-file-picker-widget and update LBUFFER
    LBUFFER="${LBUFFER}$(__lf-file-picker-widget)"
    local ret=$?
    # update LBUFFER on command line
    zle reset-prompt
    return $ret
}
