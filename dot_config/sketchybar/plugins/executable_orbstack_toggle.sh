#!/bin/bash

# Pastel color palette
PASTEL_YELLOW=0xfff9e2af
TEXT_DARK=0xff1e1e2e

if pgrep -x "OrbStack" > /dev/null; then
    sketchybar --set orbstack label="Stopping..." \
               label.font="Hack Nerd Font Mono:Medium:12.0" \
               background.color=$PASTEL_YELLOW \
               label.color=$TEXT_DARK \
               label.padding_left=10 \
               label.padding_right=10 \
               update_freq=0
    
    osascript -e 'quit app "OrbStack"'
    
    for i in {1..10}; do
        sleep 0.5
        if ! pgrep -x "OrbStack" > /dev/null; then
            break
        fi
    done
else
    sketchybar --set orbstack label="Starting..." \
               label.font="Hack Nerd Font Mono:Medium:12.0" \
               background.color=$PASTEL_YELLOW \
               label.color=$TEXT_DARK \
               label.padding_left=10 \
               label.padding_right=10 \
               update_freq=0
    
    open -a "OrbStack" -j
    
    for i in {1..10}; do
        sleep 0.5
        if pgrep -x "OrbStack" > /dev/null; then
            break
        fi
    done
fi

# Force update to show current status with proper colors
sketchybar --set orbstack update_freq=10
$CONFIG_DIR/plugins/orbstack.sh