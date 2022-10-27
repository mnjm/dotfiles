# Safe Remove
function safe_rm() {
    _alert_local 'Moving files to Trash. To use rm, Use \\rm instead of rm to bypass alias'
    trash -vI "$@"
}
function safe_rm_bk() {
    # Echo Warning
    printf "Do you really want to delete "
    tput setaf 1; printf " %s " $@; tput sgr 0; echo "? (Y/?)";
    read -k1 -s choice

    if [ $choice = 'Y' ]; then
        /bin/rm -v $@
    else
        echo 'Delete canceled.'
    fi
}

# Open clipboard through vim
function vclip() {
    # Create temp clipboard file
    xclip -selection clipboard -o > /tmp/clipboard

    # Call vim to edit
    vim /tmp/clipboard

    # Move contents back to clipboard
    cat /tmp/clipboard | xclip -selection clipboard -i

    # Remove the clipboard file
    /bin/rm /tmp/clipboard
}

# colored man pape
function man()
{
    env LESS_TERMCAP_mb=$(printf "\e[1;31m") LESS_TERMCAP_md=$(printf "\e[1;31m") LESS_TERMCAP_me=$(printf "\e[0m") LESS_TERMCAP_se=$(printf "\e[0m") LESS_TERMCAP_so=$(printf "\e[1;44;33m") LESS_TERMCAP_ue=$(printf "\e[0m") LESS_TERMCAP_us=$(printf "\e[1;32m") man "$@"
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
