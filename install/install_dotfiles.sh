#!/usr/bin/env bash
#
. $DOTFILES/install/setup_utils.sh

stdt="$DOTFILES/scripts/.local/bin/stow-dotfiles"
ignore_files=".git install misc README.md"

app_list_file=$(mktemp)
printf "Remove app from list if you don't want to install its dotfiles. Save and quit once done.\n-----\n" > $app_list_file
for f in $(ls $DOTFILES); do
    echo $ignore_files | grep -wvq $f
    [ "$?" -eq 0 ] && echo $f >> $app_list_file
done
vim $app_list_file
apps=$(cat $app_list_file | sed 1,2d)

for app in $apps; do
    if [ "$?" -eq 0 ]; then
        _alert_local "Install dotfiles for $app"
        $stdt $app
    fi
done

rm $app_list_file
