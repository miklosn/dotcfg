#!/bin/bash

if pgrep -x "OrbStack" > /dev/null; then
    sketchybar --set orbstack icon="" label="Stopping..." \
               background.color=0xffffa500 \
               icon.color=0xff000000 \
               label.color=0xff000000 \
               label.font="Hack Nerd Font Mono:Bold:10.0" \
               update_freq=0
    
    osascript -e 'quit app "OrbStack"'
    
    for i in {1..10}; do
        sleep 0.5
        if ! pgrep -x "OrbStack" > /dev/null; then
            sketchybar --set orbstack icon="" label="OrbStack: OFF" \
                       background.color=0xffff5555 \
                       icon.color=0xffffffff \
                       label.color=0xffffffff \
                       label.font="Hack Nerd Font Mono:Bold:10.0" \
                       update_freq=10
            break
        fi
    done
else
    sketchybar --set orbstack icon="" label="Starting..." \
               background.color=0xff87ceeb \
               icon.color=0xff000000 \
               label.color=0xff000000 \
               label.font="Hack Nerd Font Mono:Bold:10.0" \
               update_freq=0
    
    open -a "OrbStack" -j
    
    for i in {1..10}; do
        sleep 0.5
        if pgrep -x "OrbStack" > /dev/null; then
            sketchybar --set orbstack icon="" label="OrbStack: ON" \
                       background.color=0xff48c774 \
                       icon.color=0xff000000 \
                       label.color=0xff000000 \
                       label.font="Hack Nerd Font Mono:Bold:10.0" \
                       update_freq=10
            break
        fi
    done
fi