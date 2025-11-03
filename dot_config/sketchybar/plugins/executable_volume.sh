#!/bin/sh

# Volume plugin - Uniform design with color-coded icons

if [ "$SENDER" = "volume_change" ]; then
  VOLUME="$INFO"

  # Determine icon and color based on volume level
  if [ "$VOLUME" -eq 0 ]; then
    ICON="󰖁"
    ICON_COLOR=0xffa6adc8  # Muted - gray
  elif [ "$VOLUME" -le 30 ]; then
    ICON="󰕿"
    ICON_COLOR=0xffcdd6f4  # Low - normal
  elif [ "$VOLUME" -le 70 ]; then
    ICON="󰖀"
    ICON_COLOR=0xffcdd6f4  # Medium - normal
  else
    ICON="󰕾"
    ICON_COLOR=0xff89b4fa  # High - blue accent
  fi

  sketchybar --set "$NAME" \
    icon="$ICON" \
    icon.color="$ICON_COLOR" \
    label="$VOLUME%" \
    label.color=0xffcdd6f4
fi
