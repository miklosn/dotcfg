#!/opt/homebrew/bin/bash


source "$CONFIG_DIR/plugins/common.sh"


WORKSPACE_NUMBER="$1"

# Cleanup any existing background processes for this workspace
cleanup_workspace() {
    pkill -f "aerospace.*workspace.*$WORKSPACE_NUMBER" 2>/dev/null || true
}

trap cleanup_workspace EXIT

# Get current focused workspace - use env var if available, otherwise query aerospace
if [ -z "$FOCUSED_WORKSPACE" ]; then
    FOCUSED_WORKSPACE=$(aerospace list-workspaces --focused 2>/dev/null)
fi

if [ "$WORKSPACE_NUMBER" = "$FOCUSED_WORKSPACE" ]; then
  # Focused workspace: use accent color background for maximum visibility
  sketchybar --set "$NAME" \
    background.drawing=on \
    background.color="$ACCENT_PRIMARY" \
    icon.drawing=off \
    label.color="$TEXT_DARK" \
    label.padding_left="$TOGGLE_LABEL_PADDING_LEFT" \
    label.padding_right="$TOGGLE_LABEL_PADDING_RIGHT"
else
  # Not focused - check for windows with timeout
  (
    WINDOW_COUNT=$(timeout 2s aerospace list-windows --workspace "$WORKSPACE_NUMBER" 2>/dev/null | wc -l | tr -d ' ')

    if [ $? -eq 124 ] || [ -z "$WINDOW_COUNT" ]; then
      # Timeout/error: show as inactive
      sketchybar --set "$NAME" \
        background.drawing=off \
        icon.drawing=off \
        label.color="$TEXT_INACTIVE" \
        label.padding_left=10 \
        label.padding_right="$LABEL_PADDING_RIGHT"
    elif [ "$WINDOW_COUNT" -gt 0 ]; then
      # Has windows: show with background and brighter color for emphasis
      sketchybar --set "$NAME" \
        background.drawing=on \
        background.color="$BG_SECONDARY" \
        icon.drawing=off \
        label.color="$TEXT_PRIMARY" \
        label.padding_left=10 \
        label.padding_right="$LABEL_PADDING_RIGHT"
    else
      # Empty workspace: very dim
      sketchybar --set "$NAME" \
        background.drawing=off \
        icon.drawing=off \
        label.color="$TEXT_INACTIVE" \
        label.padding_left=10 \
        label.padding_right="$LABEL_PADDING_RIGHT"
    fi
  ) &
fi
