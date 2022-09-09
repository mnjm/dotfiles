# Safe Remove
function safe_rm() {
    # Get basedir
    BASEDIR=$(dirname $0)

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
    xclip -selection clipboard -o>/tmp/clipboard

    # Call vim to edit
    vim /tmp/clipboard

    # Move contents back to clipboard
    cat /tmp/clipboard | xclip -selection clipboard -i

    # Remove the clipboard file
    rm /tmp/clipboard
}
