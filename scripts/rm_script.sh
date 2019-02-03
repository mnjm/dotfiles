#!/bin/bash

# Get basedir
BASEDIR=$(dirname $0)

# Echo Warning
printf "Do you really want to delete in"
tput setaf 1; printf " $BASEDIR "; tput sgr 0; printf "file";
tput setaf 1; printf " %s " $@; tput sgr 0; echo "? (Y/?)";
read -n1 -s choice

if [ $choice = 'Y' ]; then
    rm -v $@
else
    echo 'Delete canceled.'
fi
