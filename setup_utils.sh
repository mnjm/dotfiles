#!/usr/bin/env bash

_alert_local() {
    color=${2:-6}
    tput setaf $color; echo $1; tput sgr0
}
