#!/usr/bin/env bash

# Prints URL of the repo

link=$(git config --get remote.origin.url)

if [ "$?" != 0 ]; then
    echo "Not a git repo."
    exit 1
fi

if [[ "$link" =~ ^git@.* ]]; then
    # SSH to https
    link="https://$(echo $link | sed -e 's/^git@//' -e 's/:/\//')"
fi

# Remove trailing .git and print
echo "$link" | sed -e 's/\.git$//'
