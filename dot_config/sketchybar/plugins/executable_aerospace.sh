#!/opt/homebrew/bin/bash

source "$CONFIG_DIR/plugins/common.sh"

WORKSPACE_NAME="$1"

# Cleanup any existing background processes for this workspace
cleanup_workspace() {
	pkill -f "aerospace.*workspace.*$WORKSPACE_NAME" 2>/dev/null || true
}

trap cleanup_workspace EXIT

# Use full path to aerospace binary
AEROSPACE_CMD="/opt/homebrew/bin/aerospace"

# Debug logging
if [ "${SKETCHYBAR_DEBUG:-0}" = "1" ]; then
	echo "[AEROSPACE $NAME] Workspace: $WORKSPACE_NAME, ENV FOCUSED: $FOCUSED_WORKSPACE" >&2
fi

# Get current focused workspace - query aerospace directly to be sure
if [ -z "$FOCUSED_WORKSPACE" ]; then
	FOCUSED_WORKSPACE=$($AEROSPACE_CMD list-workspaces --focused 2>/dev/null)
fi

# Double-check focused workspace by querying again (defensive)
FOCUSED_CHECK=$($AEROSPACE_CMD list-workspaces --focused 2>/dev/null)
if [ -n "$FOCUSED_CHECK" ]; then
	FOCUSED_WORKSPACE="$FOCUSED_CHECK"
fi

if [ "${SKETCHYBAR_DEBUG:-0}" = "1" ]; then
	echo "[AEROSPACE $NAME] Query FOCUSED: $FOCUSED_WORKSPACE, Match: $([ "$WORKSPACE_NAME" = "$FOCUSED_WORKSPACE" ] && echo "YES" || echo "NO")" >&2
fi

# Check if this workspace is focused
if [ "$WORKSPACE_NAME" = "$FOCUSED_WORKSPACE" ]; then
	# Focused workspace: use accent color background for maximum visibility
	sketchybar --set "$NAME" \
		background.drawing=on \
		background.color="$ACCENT_PRIMARY" \
		icon.drawing=off \
		label.color="$TEXT_DARK" \
		label.padding_left="$TOGGLE_LABEL_PADDING_LEFT" \
		label.padding_right="$TOGGLE_LABEL_PADDING_RIGHT"

	if [ "${SKETCHYBAR_DEBUG:-0}" = "1" ]; then
		echo "[AEROSPACE $NAME] Set FOCUSED state" >&2
	fi
else
	# Not focused - check for windows in background
	(
		if [ "${SKETCHYBAR_DEBUG:-0}" = "1" ]; then
			echo "[AEROSPACE $NAME] Background check starting" >&2
		fi

		# Check if workspace exists (especially for named workspaces)
		WORKSPACE_EXISTS=$($AEROSPACE_CMD list-workspaces --all 2>/dev/null | grep -q "^$WORKSPACE_NAME$" && echo "yes" || echo "no")
		if [ "${SKETCHYBAR_DEBUG:-0}" = "1" ]; then
			echo "[AEROSPACE $NAME] Workspace exists: $WORKSPACE_EXISTS" >&2
		fi

		if [ "$WORKSPACE_EXISTS" = "no" ]; then
			# Workspace doesn't exist yet, show as very inactive
			if [ "${SKETCHYBAR_DEBUG:-0}" = "1" ]; then
				echo "[AEROSPACE $NAME] Workspace doesn't exist" >&2
			fi
			sketchybar --set "$NAME" \
				background.drawing=off \
				icon.drawing=off \
				label.color="$TEXT_INACTIVE" \
				label.padding_left=10 \
				label.padding_right="$LABEL_PADDING_RIGHT"
			exit 0
		fi

		# Check for windows
		WINDOW_COUNT=$($AEROSPACE_CMD list-windows --workspace "$WORKSPACE_NAME" 2>/dev/null | wc -l | tr -d ' ')

		if [ "${SKETCHYBAR_DEBUG:-0}" = "1" ]; then
			echo "[AEROSPACE $NAME] Window count: $WINDOW_COUNT" >&2
		fi

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
