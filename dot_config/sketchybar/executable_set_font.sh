#!/opt/homebrew/bin/bash

CONFIG_DIR="$(cd "$(dirname "$0")" && pwd)"
FONT_FILE="$CONFIG_DIR/.font"

FONTS=(
    "Hack Nerd Font Mono"
    "JetBrainsMono Nerd Font Mono"
    "FiraCode Nerd Font Mono"
    "IBMPlexMono Nerd Font Mono"
    "CaskaydiaCove Nerd Font Mono"
    "Meslo Nerd Font Mono"
)

FONT_NAME="$1"

if [[ -z "$FONT_NAME" ]]; then
    echo "Usage: $0 <font_name>"
    echo ""
    echo "Available fonts:"
    for font in "${FONTS[@]}"; do
        echo "  - $font"
    done
    echo ""
    if [[ -f "$FONT_FILE" ]]; then
        echo "Current font: $(cat "$FONT_FILE")"
    else
        echo "Current font: Hack Nerd Font Mono (default)"
    fi
    exit 1
fi

# Simple validation - check if font is in list
VALID=false
for font in "${FONTS[@]}"; do
    if [[ "$font" == "$FONT_NAME" ]]; then
        VALID=true
        break
    fi
done

if [[ "$VALID" == "false" ]]; then
    echo "Error: Unknown font '$FONT_NAME'"
    echo ""
    echo "Available fonts:"
    for font in "${FONTS[@]}"; do
        echo "  - $font"
    done
    exit 1
fi

# Save font preference
echo "$FONT_NAME" > "$FONT_FILE"
echo "Font set to: $FONT_NAME"

# Export for current session
export SKETCHYBAR_FONT="$FONT_NAME"

# Reload sketchybar
brew services restart sketchybar

echo "✅ Font changed to $FONT_NAME"
