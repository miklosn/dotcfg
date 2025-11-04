#!/bin/sh

# Pastel color palette
PASTEL_YELLOW=0xfff9e2af
TEXT_DARK=0xff1e1e2e

# Show toggling state
sketchybar --set wifi label="Toggling..." \
           background.color=$PASTEL_YELLOW \
           label.color=$TEXT_DARK \
           label.padding_left=10 \
           label.padding_right=10

# Turn off WiFi
networksetup -setairportpower en0 off

# Brief pause
sleep 1

# Turn on WiFi
networksetup -setairportpower en0 on

# Show reconnecting state
sketchybar --set wifi label="Connecting..." \
           background.color=$PASTEL_YELLOW \
           label.color=$TEXT_DARK \
           label.padding_left=10 \
           label.padding_right=10

# Wait a bit for connection
sleep 2

# Force update of the WiFi status
$CONFIG_DIR/plugins/wifi.sh