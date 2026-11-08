#!/bin/bash
STATUS=$(playerctl status 2>/dev/null)

if [ "$STATUS" = "Playing" ]; then
    ICON="󰏤"
elif [ "$STATUS" = "Paused" ]; then
    ICON="󰐊"
else
    echo ""
    exit 0
fi

echo "$ICON"
