#!/usr/bin/env bash

# Aerospace workspace plugin - Uniform design with consistent styling

WORKSPACE_NUMBER="$1"

# Color palette (matching main config)
FOCUSED_ICON=0xffcdd6f4      # Bright white for focused workspace
FOCUSED_LABEL=0xff89b4fa     # Blue accent for focused label
ACTIVE_ICON=0xffa6adc8       # Dimmer for active workspace with windows
ACTIVE_LABEL=0xffa6adc8      # Dimmer for active label
INACTIVE_ICON=0xff6c7086     # Dark gray for empty workspace
INACTIVE_LABEL=0xff6c7086    # Dark gray for empty label
BG_COLOR=0xff313244          # Background for focused

if [ "$WORKSPACE_NUMBER" = "$FOCUSED_WORKSPACE" ]; then
  # Focused workspace: show with background and bright colors
  sketchybar --set "$NAME" \
    background.drawing=on \
    background.color=$BG_COLOR \
    icon.color=$FOCUSED_ICON \
    label.color=$FOCUSED_LABEL
else
  # Not focused - check for windows in background to avoid blocking
  (
    WINDOW_COUNT=$(aerospace list-windows --workspace "$WORKSPACE_NUMBER" 2>/dev/null | wc -l | tr -d ' ')
    if [ "$WINDOW_COUNT" -gt 0 ]; then
      # Workspace has windows: show as active (no background)
      sketchybar --set "$NAME" \
        background.drawing=off \
        icon.color=$ACTIVE_ICON \
        label.color=$ACTIVE_LABEL
    else
      # Workspace has no windows: show as inactive
      sketchybar --set "$NAME" \
        background.drawing=off \
        icon.color=$INACTIVE_ICON \
        label.color=$INACTIVE_LABEL
    fi
  ) &
fi
