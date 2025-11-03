#!/bin/sh

# Front App plugin - Uniform design with consistent styling

# Color palette (matching main config)
TEXT=0xffcdd6f4

if [ "$SENDER" = "front_app_switched" ]; then
  # Truncate long app names
  APP_NAME="$INFO"

  if [ ${#APP_NAME} -gt 20 ]; then
    APP_NAME="${APP_NAME:0:18}.."
  fi

  sketchybar --set "$NAME" \
    icon="" \
    icon.color=0xff89b4fa \
    label="$APP_NAME" \
    label.color=$TEXT
fi
