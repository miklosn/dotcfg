#!/opt/homebrew/bin/bash

source "$CONFIG_DIR/themes.sh"

CURRENT_THEME=$(cat "$CONFIG_DIR/.theme" 2>/dev/null || echo "tokyo_night")

# Find current index
CURRENT_INDEX=0
for i in "${!AVAILABLE_THEMES[@]}"; do
    if [[ "${AVAILABLE_THEMES[$i]}" == "$CURRENT_THEME" ]]; then
        CURRENT_INDEX=$i
        break
    fi
done

# Get next theme (cycle)
NEXT_INDEX=$(( (CURRENT_INDEX + 1) % ${#AVAILABLE_THEMES[@]} ))
NEXT_THEME="${AVAILABLE_THEMES[$NEXT_INDEX]}"

# Save theme
echo "$NEXT_THEME" > "$CONFIG_DIR/.theme"

# Reload config (this sources the new theme and updates all items)
sketchybar --reload
