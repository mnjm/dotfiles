#!/usr/bin/env bash

# Configuration
LOW_PERC=20
CRITICAL_PERC=10
CHARGED_PERC=95
SLEEP_TIME=2m

# State lookup
# 0: NORMAL
# 1: LOW or % < LOW_PERC and discharging
# 2: CRITICAL % < CRITICAL_PERC and discharging
# 3: CHARGING
# 4: FULL or % > CHARGED_PERC and charging

DISCHARGING=0
LOW_DISCHARGING=1
CRIT_DISCHARGING=2
CHARGING=3
FULL=4

DEBUG=1

ICON_CRIT=$HOME/.config/dunst/icons/battery-critical.png
ICON_LOW=$HOME/.config/dunst/icons/battery-low.png
ICON_CHARGING=$HOME/.config/dunst/icons/battery-charging.png
ICON_DISCHARGING=$HOME/.config/dunst/icons/battery-discharging.png
ICON_FULL=$HOME/.config/dunst/icons/battery-full.png

get_awk_source() {
    cat <<EOF
BEGIN {
    FS="=";
}
\$1 ~ /ENERGY_FULL$/ {
    f += \$2;
}
\$1 ~ /ENERGY_NOW\$/ {
    n += \$2;
}
\$1 ~ /CHARGE_FULL$/ {
    f += \$2;
}
\$1 ~ /CHARGE_NOW\$/ {
    n += \$2;
}
END {
    print int(100*n/f);
}
EOF
}

is_battery_discharging() {
    grep STATUS=Discharging "${BATTERIES[@]}" && return 0
    return 1
} >/dev/null

get_battery_perc() {
    awk -f <(get_awk_source) "${BATTERIES[@]}"
}

get_state() {
    PERC=$1

    if is_battery_discharging; then
        if [[ $PERC -le $CRITICAL_PERC ]]; then
            return $CRIT_DISCHARGING
        elif [[ $PERC -le $LOW_PERC ]]; then
            return $LOW_DISCHARGING
        else
            return $DISCHARGING
        fi
    else
        if [[ $PERC -ge $CHARGED_PERC ]]; then
            return $FULL
        else
            return $CHARGING
        fi
    fi
}

if ls /sys/class/power_supply/BAT*/uevent > /dev/null 2>&1; then
    BATTERIES=( /sys/class/power_supply/BAT*/uevent )
elif ls /sys/class/power_supply/CMB*/uevent > /dev/null 2>&1; then
    BATTERIES=( /sys/class/power_supply/CMB*/uevent )
else
    echo "No batteries found"
    exit 1
fi

state=$DISCHARGING

while true; do
    old_state=$state
    PERC=$(get_battery_perc)
    get_state $PERC
    state=$?

    if [[ $state -ne $old_state ]]; then
        case $state in
            $CRIT_DISCHARGING)
                dunstify -u critical -i $ICON_CRIT "Battery too low (${PERC}%)" "Plug-In to power immediately!"
                ;;
            $LOW_DISCHARGING)
                dunstify -u normal -i $ICON_LOW "Battery low (${PERC}%)" "Plug-In to power ASAP"
                ;;
            $CHARGING)
                dunstify -u low -i $ICON_CHARGING "Power cord inserted (${PERC}%)" "Battery charging"
                ;;
            $DISCHARGING)
                dunstify -u low -i $ICON_DISCHARGING "Power cord removed (${PERC}%)" "Battery discharging"
                ;;
            $FULL)
                dunstify -u normal -i $ICON_FULL "Battery fully charged (${PERC}%)" "Un-plug power cord"
                ;;
        esac
    fi
    sleep "${SLEEP_TIME}"

done
