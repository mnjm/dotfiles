# Safe Remove
function safe_rm() {
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

# take = mkdir + cd
function take() {
    mkdir -p $1
    cd $1
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
function man ()
{
    env LESS_TERMCAP_mb=$(printf "\e[1;31m") LESS_TERMCAP_md=$(printf "\e[1;31m") LESS_TERMCAP_me=$(printf "\e[0m") LESS_TERMCAP_se=$(printf "\e[0m") LESS_TERMCAP_so=$(printf "\e[1;44;33m") LESS_TERMCAP_ue=$(printf "\e[0m") LESS_TERMCAP_us=$(printf "\e[1;32m") man "$@"
}
