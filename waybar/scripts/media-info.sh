#!/bin/bash
STATUS=$(playerctl status 2>/dev/null)

ARTIST=$(playerctl metadata artist 2>/dev/null)
TITLE=$(playerctl metadata title 2>/dev/null)

echo "$TITLE - $ARTIST"
