#!/bin/bash

# OrbStack plugin - Text-based design with pastel background colors

# Pastel color palette for background
PASTEL_GREEN=0xffa6e3a1
BG_PRIMARY=0xff313244
TEXT_PRIMARY=0xffcdd6f4
TEXT_DARK=0xff1e1e2e

if pgrep -x "OrbStack" > /dev/null; then
    BG_COLOR=$PASTEL_GREEN
    LABEL_COLOR=$TEXT_DARK
else
    BG_COLOR=$BG_PRIMARY
    LABEL_COLOR=$TEXT_PRIMARY
fi

sketchybar --set $NAME \
    icon.drawing=off \
    label="Orb" \
    label.color=$LABEL_COLOR \
    label.padding_left=10 \
    label.padding_right=10 \
    background.color=$BG_COLOR
