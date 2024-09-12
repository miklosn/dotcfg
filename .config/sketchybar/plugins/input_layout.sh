#!/bin/sh

CURRENT_LAYOUT=$(defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleCurrentKeyboardLayoutInputSourceID)

VAL="❓"
case $CURRENT_LAYOUT in
com.apple.keylayout.US)
  VAL="US"
  ;;
com.apple.keylayout.Hungarian)
  VAL="HU"
  ;;
esac

sketchybar --set "$NAME" label="${VAL}"
