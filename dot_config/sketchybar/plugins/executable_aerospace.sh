#!/usr/bin/env bash

# make sure it's executable with:
# chmod +x ~/.config/sketchybar/plugins/aerospace.sh

WORKSPACE_NUMBER="$1"
FOCUSED_ICON_COLOR="0xffffffff"       # Bright white for focused workspace number
FOCUSED_LABEL_COLOR="0xffffffff"     # Bright white for focused workspace label
ACTIVE_ICON_COLOR="0xffaaaaaa"       # Brighter gray for non-focused workspace number
ACTIVE_LABEL_COLOR="0xffaaaaaa"      # Brighter gray for non-focused workspace label
INACTIVE_ICON_COLOR="0xff555555"     # Medium gray for empty workspace number
INACTIVE_LABEL_COLOR="0xff555555"    # Medium gray for empty workspace label

if [ "$WORKSPACE_NUMBER" = "$FOCUSED_WORKSPACE" ]; then
  # Focused workspace: bright color, no background
  sketchybar --set "$NAME" background.drawing=off \
                           icon.color="$FOCUSED_ICON_COLOR" \
                           label.color="$FOCUSED_LABEL_COLOR"
else
  # Not focused - check for windows in background to avoid blocking
  (
    WINDOW_COUNT=$(aerospace list-windows --workspace "$WORKSPACE_NUMBER" 2>/dev/null | wc -l | tr -d ' ')
    if [ "$WINDOW_COUNT" -gt 0 ]; then
      # Workspace has windows: brighter gray
      sketchybar --set "$NAME" background.drawing=off \
                               icon.color="$ACTIVE_ICON_COLOR" \
                               label.color="$ACTIVE_LABEL_COLOR"
    else
      # Workspace has no windows: medium gray
      sketchybar --set "$NAME" background.drawing=off \
                               icon.color="$INACTIVE_ICON_COLOR" \
                               label.color="$INACTIVE_LABEL_COLOR"
    fi
  ) &
fi