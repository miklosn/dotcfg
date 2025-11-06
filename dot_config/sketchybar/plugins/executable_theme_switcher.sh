#!/opt/homebrew/bin/bash

source "$CONFIG_DIR/themes.sh"

CURRENT_THEME=$(cat "$CONFIG_DIR/.theme" 2>/dev/null || echo "tokyo_night")

# Get display name from single source of truth
ICON="󰖔"
LABEL=$(get_theme_name "$CURRENT_THEME")

# Use colors from current theme
sketchybar --set "$NAME" \
    icon="$ICON" \
    icon.color="$ACCENT_PRIMARY" \
    label="$LABEL" \
    label.color="$TEXT_PRIMARY" \
    background.color="$BG_PRIMARY" \
    background.corner_radius="$CORNER_RADIUS" \
    background.height="$ITEM_HEIGHT" \
    padding_left=4 \
    padding_right=4
