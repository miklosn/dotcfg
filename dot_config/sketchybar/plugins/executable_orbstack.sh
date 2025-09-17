#!/bin/bash

if pgrep -x "OrbStack" > /dev/null; then
    LABEL="OrbStack: ON"
    ICON=""
    COLOR=0xff48c774
    ICON_COLOR=0xff000000
    LABEL_COLOR=0xff000000
else
    LABEL="OrbStack: OFF"
    ICON=""
    COLOR=0xffff5555
    ICON_COLOR=0xffffffff
    LABEL_COLOR=0xffffffff
fi

sketchybar --set $NAME icon="$ICON" label="$LABEL" \
           background.color="$COLOR" \
           icon.color="$ICON_COLOR" \
           label.color="$LABEL_COLOR" \
           label.font="Hack Nerd Font Mono:Bold:10.0"