#!/opt/homebrew/bin/bash

# Source common styling
source "$CONFIG_DIR/plugins/common.sh"

# Microphone toggle - Mute/unmute microphone on click

# Get current input volume
CURRENT_VOLUME=$(osascript -e 'input volume of (get volume settings)' 2>/dev/null)

if [ -z "$CURRENT_VOLUME" ]; then
  # No input device
  exit 0
fi

if [ "$CURRENT_VOLUME" -eq 0 ]; then
  # Currently muted, unmute to 50%
  osascript -e 'set volume input volume 50' 2>/dev/null
else
  # Currently active, mute
  osascript -e 'set volume input volume 0' 2>/dev/null
fi

# Force update the microphone item
sketchybar --trigger microphone_change
