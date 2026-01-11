#!/opt/homebrew/bin/bash

CONFIG_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$CONFIG_DIR/themes.sh"

THEME_NAME="$1"

if [[ -z "$THEME_NAME" ]]; then
    echo "Usage: $0 <theme_name>"
    echo ""
    echo "Available themes:"
    for theme in "${AVAILABLE_THEMES[@]}"; do
        echo "  $theme - $(get_theme_name "$theme")"
    done
    echo ""
    if [[ -f "$THEME_FILE" ]]; then
        echo "Current theme: $(cat "$THEME_FILE")"
    else
        echo "Current theme: tokyo_night (default)"
    fi
    exit 1
fi

VALID_PATTERN=$(get_theme_pattern)
if ! echo "$THEME_NAME" | grep -qE "^($VALID_PATTERN)$"; then
    echo "Error: Unknown theme '$THEME_NAME'"
    echo ""
    echo "Available: ${AVAILABLE_THEMES[*]}"
    exit 1
fi

echo "$THEME_NAME" > "$THEME_FILE"
echo "Switching to theme: $THEME_NAME"
brew services restart sketchybar

echo "✅ Theme switched to $THEME_NAME"
