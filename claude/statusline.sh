#!/usr/bin/env bash
# Claude Code statusline: model (effort) Ctx:% 5H:% (reset time) W:% (reset date time) Working|Done
input=$(cat)
j() { echo "$input" | jq -r "$1 // empty"; }
# epoch -> formatted local time (GNU date, falls back to BSD/macOS date)
fmt() { date -d "@$1" +"$2" 2>/dev/null || date -r "$1" +"$2"; }
left() { printf '%.0f' "$(awk -v u="$1" 'BEGIN{print 100-u}')"; }

m=$(j '.model.display_name')
e=$(j '.effort.level')
r=$(j '.context_window.remaining_percentage')
f=$(j '.rate_limits.five_hour.used_percentage')
fr=$(j '.rate_limits.five_hour.resets_at')
w=$(j '.rate_limits.seven_day.used_percentage')
wr=$(j '.rate_limits.seven_day.resets_at')
sid=$(j '.session_id')
st=$(cat "${TMPDIR:-/tmp}/claude-status-$sid" 2>/dev/null)

out="$m"
[ -n "$e" ] && out="$out ($e)"
[ -n "$r" ] && out="$out Ctx:$(printf '%.0f' "$r")%" || out="$out Ctx:?%"
[ -n "$f" ] && out="$out 5H:$(left "$f")%" || out="$out 5H:?%"
[ -n "$fr" ] && out="$out ($(fmt "$fr" '%H:%M'))"
[ -n "$w" ] && out="$out W:$(left "$w")%" || out="$out W:?%"
[ -n "$wr" ] && out="$out ($(fmt "$wr" '%d %b %H:%M'))"
if [ "$st" = working ]; then
  out="$out \033[33mWorking\033[0m"
else
  out="$out \033[37mDone\033[0m"
fi
printf '%b\n' "$out"
