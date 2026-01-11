#!/opt/homebrew/bin/bash


source "$CONFIG_DIR/plugins/common.sh"


# Validate required environment
validate_env "CONFIG_DIR"

# Get current keyboard layout with error handling
if ! CURRENT_LAYOUT=$(defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleCurrentKeyboardLayoutInputSourceID 2>/dev/null) || [ -z "$CURRENT_LAYOUT" ]; then
    handle_error "Failed to get input layout"
fi

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

# Set item style and content (label-only, so use toggle padding for balance)
set_label_only "$VAL" "$TEXT_PRIMARY" "$BG_PRIMARY"
