# tmux + fzf session selector
function tmuxn()
{
    sessions=$(tmux ls 2>/dev/null)
    selected=$(echo $sessions | cut -d: -f1 | ~/.fzf/bin/fzf --reverse --no-multi --print-query \
        --preview "tmux capture-pane -pt {}" | tail -n1)
    if [ -z "$TMUX" ]; then
        tmux new -As $selected
    else
        if  ! tmux has-session -t $selected 2>/dev/null; then
            tmux new -ds $selected
        fi
        tmux switch-client -t $selected
    fi
}
