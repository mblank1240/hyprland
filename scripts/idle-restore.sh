#!/bin/sh
# hypridle on-resume: undo the idle dim, back to the gamma that hyprsunset.conf
# schedules for this time of day (90% from 18:00 to 07:00, 100% otherwise).
h=$(date +%H)
if [ "$h" -ge 18 ] || [ "$h" -lt 7 ]; then
    hyprctl hyprsunset gamma 90
else
    hyprctl hyprsunset gamma 100
fi
