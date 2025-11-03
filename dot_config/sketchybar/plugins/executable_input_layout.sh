#!/bin/sh

# Input Layout plugin - Uniform design with consistent styling

# Color palette (matching main config)
TEXT=0xffcdd6f4

# Get current keyboard layout
CURRENT_LAYOUT=$(defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleCurrentKeyboardLayoutInputSourceID)

# Map layout to display value
VAL="??"
case $CURRENT_LAYOUT in
com.apple.keylayout.US)
  VAL="US"
  ;;
com.apple.keylayout.USInternational-PC)
  VAL="US"
  ;;
com.apple.keylayout.Hungarian)
  VAL="HU"
  ;;
com.apple.keylayout.ABC)
  VAL="ABC"
  ;;
com.apple.keylayout.British)
  VAL="GB"
  ;;
com.apple.keylayout.German)
  VAL="DE"
  ;;
com.apple.keylayout.French)
  VAL="FR"
  ;;
esac

sketchybar --set "$NAME" \
  icon.drawing=off \
  label="$VAL" \
  label.color=$TEXT
