# ███████╗██╗     ███████╗    ██╗    ██╗██╗██████╗  ██████╗ ███████╗████████╗███████╗
# ╚══███╔╝██║     ██╔════╝    ██║    ██║██║██╔══██╗██╔════╝ ██╔════╝╚══██╔══╝██╔════╝
#   ███╔╝ ██║     █████╗      ██║ █╗ ██║██║██║  ██║██║  ███╗█████╗     ██║   ███████╗
#  ███╔╝  ██║     ██╔══╝      ██║███╗██║██║██║  ██║██║   ██║██╔══╝     ██║   ╚════██║
# ███████╗███████╗███████╗    ╚███╔███╔╝██║██████╔╝╚██████╔╝███████╗   ██║   ███████║
# ╚══════╝╚══════╝╚══════╝     ╚══╝╚══╝ ╚═╝╚═════╝  ╚═════╝ ╚══════╝   ╚═╝   ╚══════╝

# cd previous using fzf
function _fzf-cdprev-widget() {
    setopt localoptions pipefail no_aliases 2> /dev/null
    # skip the first entry as it will be PWD. and FZF though the remaing entries
    dir="$(dirs -p | tail -n +2 | fzf-tmux -p 85% --reverse --no-multi)"
    if [[ -z $dir ]]; then
        zle redisplay
        return 0
    fi
    # save the command line so it can be update after cd
    zle push-line
    # Modify the buffer with cd
    dir=$(echo $dir | sed 's/ /\\ /g') # escape space dir if any
    BUFFER="builtin cd -- $dir"
    # exec BUFFER
    zle accept-line
    local ret=$?
    unset dir
    # reset to saved line, this will restore from `push-line`
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
        # save the command line so that it can be auto-restored later
        zle push-line
        # change command line to cd
        BUFFER="builtin cd -- ${(q)selected}"
        # exec command line
        zle accept-line
        ret=$?
        # reset to saved line and restore
        zle reset-prompt
    else
        zle redisplay
    fi
    return $ret
}

# lf files picker - paste selected files into command line
function _lf-file-picker-widget() {
    function __lf-file-picker-widget() {
        setopt localoptions pipefail no_aliases 2> /dev/null
        local selected="$(lf -print-selection)"
        # space seperate selected (and escape ' ' if any)
        if [ ! -z $selected ]; then
            echo $selected | while read item; do
                echo -n "${(q)item} "
            done
        fi
        return $?
    }
    # call __lf-file-picker-widget and update LBUFFER
    LBUFFER="${LBUFFER}$(__lf-file-picker-widget)"
    local ret=$?
    # update LBUFFER on command line
    zle reset-prompt
    return $ret
}
