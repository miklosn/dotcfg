#!/opt/homebrew/bin/bash

# Source common styling
source "$CONFIG_DIR/plugins/common.sh"

if pgrep -x "OrbStack" > /dev/null; then
    set_item_colored_bg "$COLOR_WARNING"
    sketchybar --set orbstack label="Stopping..." \
               label.padding_left="$TOGGLE_LABEL_PADDING_LEFT" \
               label.padding_right="$TOGGLE_LABEL_PADDING_RIGHT" \
               update_freq=0

    osascript -e 'quit app "OrbStack"'

    for i in {1..10}; do
        sleep 0.5
        if ! pgrep -x "OrbStack" > /dev/null; then
            break
        fi
    done
else
    set_item_colored_bg "$COLOR_WARNING"
    sketchybar --set orbstack label="Starting..." \
               label.padding_left="$TOGGLE_LABEL_PADDING_LEFT" \
               label.padding_right="$TOGGLE_LABEL_PADDING_RIGHT" \
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
"$CONFIG_DIR"/plugins/orbstack.sh
