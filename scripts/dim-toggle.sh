#!/bin/bash
# Waybar toggle for screen dimming (evening warm/dim + idle dim).
# Both go through hyprsunset, so "off" = hyprsunset not running (gamma resets to normal).
#   dim-toggle.sh          -> print waybar JSON status
#   dim-toggle.sh toggle   -> start/stop hyprsunset, refresh the waybar module

if [ "$1" = "toggle" ]; then
    if pgrep -x hyprsunset >/dev/null; then
        pkill -x hyprsunset
    else
        setsid -f hyprsunset >/dev/null 2>&1
    fi
    sleep 0.3
    pkill -RTMIN+9 waybar
    exit 0
fi

if pgrep -x hyprsunset >/dev/null; then
    printf '{"text":"%s","class":"on","tooltip":"Screen dimming: on (evening warm/dim + idle dim)\\nClick to turn off"}\n' $'\U000F0594'
else
    printf '{"text":"%s","class":"off","tooltip":"Screen dimming: off\\nClick to turn on"}\n' $'\U000F0599'
fi
