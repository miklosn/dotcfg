#!/opt/homebrew/bin/bash


source "$CONFIG_DIR/plugins/common.sh"


# Validate required environment
validate_env "CONFIG_DIR"

if [ "$SENDER" = "front_app_switched" ]; then
  # Validate input
  if [ -z "$INFO" ]; then
    handle_error "No app info provided"
  fi
  
  # Truncate long app names
  APP_NAME="$INFO"

  if [ ${#APP_NAME} -gt 20 ]; then
    APP_NAME="${APP_NAME:0:18}.."
  fi

  # Set item style and content
  set_item_style
  sketchybar --set "$NAME" \
    icon="" \
    icon.color=$COLOR_INFO \
    label="$APP_NAME" \
    label.color=$TEXT_PRIMARY
fi
