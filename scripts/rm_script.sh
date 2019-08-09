#!/bin/bash

# Get basedir
BASEDIR=$(dirname $0)

# Echo Warning
printf "Do you really want to delete "
tput setaf 1; printf " %s " $@; tput sgr 0; echo "? (Y/?)";
read -n1 -s choice

if [ $choice = 'Y' ]; then
    rm -v $@
else
    echo 'Delete canceled.'
fi
