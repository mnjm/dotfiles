# Open clipboard through vim
function vclip() {
    # Create temp clipboard file
    xclip -selection clipboard -o>/tmp/clipboard

    # Call vim to edit
    vim /tmp/clipboard

    # Move contents back to clipboard
    cat /tmp/clipboard | xclip -selection clipboard -i

    # Remove the clipboard file
    /bin/rm /tmp/clipboard
}

