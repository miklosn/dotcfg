#!/bin/sh

# Show toggling state
sketchybar --set wifi label="Toggling..." background.color=0xffff9500 icon=

# Turn off WiFi
networksetup -setairportpower en0 off

# Brief pause
sleep 1

# Turn on WiFi
networksetup -setairportpower en0 on

# Show reconnecting state
sketchybar --set wifi label="Connecting..." background.color=0xff007aff icon=󰤨

# Wait a bit for connection
sleep 2

# Reset to normal color and update status
sketchybar --set wifi background.color=0xff48c774 icon=

# Force update of the WiFi status
$CONFIG_DIR/plugins/wifi.sh