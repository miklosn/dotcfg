#!/opt/homebrew/bin/bash


source "$CONFIG_DIR/plugins/common.sh"


if [ "$SENDER" = "volume_change" ]; then
  VOLUME="$INFO"

  # Determine icon and color based on volume level
  if [ "$VOLUME" -eq 0 ]; then
    ICON="󰖁"
    ICON_COLOR=$TEXT_SECONDARY  # Muted - gray
  elif [ "$VOLUME" -le 30 ]; then
    ICON="󰕿"
    ICON_COLOR=$TEXT_PRIMARY  # Low - normal
  elif [ "$VOLUME" -le 70 ]; then
    ICON="󰖀"
    ICON_COLOR=$TEXT_PRIMARY  # Medium - normal
  else
    ICON="󰕾"
    ICON_COLOR=$COLOR_INFO  # High - info accent
  fi

  # Set item style and content
  set_item_style
  sketchybar --set "$NAME" \
    icon="$ICON" \
    icon.color="$ICON_COLOR" \
    label="$VOLUME%" \
    label.color=$TEXT_PRIMARY
fi
