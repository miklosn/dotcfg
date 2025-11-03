#!/bin/sh

# Clock plugin - Uniform design with consistent styling

# Color palette (matching main config)
TEXT=0xffcdd6f4

# Format: MM-DD HH:MM
LABEL="$(date '+%m-%d %H:%M')"

sketchybar --set "$NAME" \
  icon="" \
  icon.color=0xff89b4fa \
  label="$LABEL" \
  label.color=$TEXT
