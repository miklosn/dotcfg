#!/opt/homebrew/bin/bash


source "$CONFIG_DIR/plugins/common.sh"


# Validate required environment
validate_env "CONFIG_DIR"

# Format: MM-DD HH:MM
LABEL="$(date '+%m-%d %H:%M' 2>/dev/null)" || handle_error "Date command failed"

# Set item style and content
set_item_style
sketchybar --set "$NAME" \
    icon="" \
    icon.color=$COLOR_INFO \
    label="$LABEL" \
    label.color=$TEXT_PRIMARY
