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
