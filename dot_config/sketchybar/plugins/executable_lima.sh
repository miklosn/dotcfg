#!/bin/sh

# Lima plugin - Uniform design with color-coded status

# Color palette (matching main config)
GREEN=0xffa6e3a1
YELLOW=0xfff9e2af
GRAY=0xffa6adc8
TEXT=0xffcdd6f4

# Count running VMs
X=$(limactl list 2>/dev/null | grep Running | wc -l | xargs)

# Set icon color based on VM count
if [ "$X" -gt 0 ]; then
  ICON_COLOR=$GREEN  # Green when VMs are running
else
  ICON_COLOR=$GRAY   # Gray when no VMs
fi

sketchybar --set "$NAME" \
  icon="󰋗" \
  icon.color="$ICON_COLOR" \
  label="$X" \
  label.color=$TEXT
