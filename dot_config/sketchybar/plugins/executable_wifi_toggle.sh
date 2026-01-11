#!/opt/homebrew/bin/bash

# Source common styling
source "$CONFIG_DIR/plugins/common.sh"

# Show toggling state
set_item_colored_bg "$COLOR_WARNING"
sketchybar --set wifi label="Toggling..." \
           label.padding_left="$TOGGLE_LABEL_PADDING_LEFT" \
           label.padding_right="$TOGGLE_LABEL_PADDING_RIGHT"

# Turn off WiFi
networksetup -setairportpower en0 off

# Brief pause
sleep 1

# Turn on WiFi
networksetup -setairportpower en0 on

# Show reconnecting state
set_item_colored_bg "$COLOR_WARNING"
sketchybar --set wifi label="Connecting..." \
           label.padding_left="$TOGGLE_LABEL_PADDING_LEFT" \
           label.padding_right="$TOGGLE_LABEL_PADDING_RIGHT"

# Wait a bit for connection
sleep 2

# Force update of the WiFi status
"$CONFIG_DIR"/plugins/wifi.sh
