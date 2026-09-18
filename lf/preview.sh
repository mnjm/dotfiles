#!/bin/sh

case "$(file --dereference --brief --mime-type -- "$1")" in
    text/* | */xml | application/json) bat --line-range :150 --terminal-width "$(($4-2))" -f "$1" ;;
    video/*) mediainfo "$1";;
    image/*) chafa -f sixel -s "$2x$3" --animate off --polite on -t 1 --bg black "$1" ;;
    inode/directory) ls "$1";;
    *) file "$1" | awk -F'[:,]' '{ print $2 }';;
esac
exit 0
