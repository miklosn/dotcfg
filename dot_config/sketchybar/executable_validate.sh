#!/opt/homebrew/bin/bash

# SketchyBar Configuration Validation Script
# Run this script to validate all shell scripts for common issues

set -e

CONFIG_DIR="$(cd "$(dirname "$0")" && pwd)"
ERRORS=0

echo "🔍 SketchyBar Configuration Validation"
echo "========================================"
echo ""

# Check if shellcheck is installed
if ! command -v shellcheck &> /dev/null; then
    echo "⚠️  shellcheck not found. Install with: brew install shellcheck"
    echo ""
    echo "Skipping shellcheck validation..."
    SHELLCHECK_AVAILABLE=false
else
    echo "✓ shellcheck found"
    SHELLCHECK_AVAILABLE=true
fi

echo ""
echo "Validating shell scripts..."
echo ""

# Find all .sh files and sketchybarrc
SHELL_FILES=$(find "$CONFIG_DIR" -type f \( -name "*.sh" -o -name "sketchybarrc" \) | sort)

for file in $SHELL_FILES; do
    filename=$(basename "$file")

    # Check if file is executable
    if [[ "$filename" != "common.sh" ]] && [[ "$filename" != "themes.sh" ]]; then
        if [[ ! -x "$file" ]]; then
            echo "❌ $filename - Not executable"
            ERRORS=$((ERRORS + 1))
        else
            echo "✓ $filename - Executable"
        fi
    fi

    # Run shellcheck if available
    if [[ "$SHELLCHECK_AVAILABLE" == "true" ]]; then
        # Exclude some checks:
        # SC1090: Can't follow non-constant source
        # SC2034: Variable appears unused (theme variables are exported)
        # SC2154: Variable referenced but not assigned (comes from sourced files)
        # SC2086: Double quote to prevent globbing - acceptable for sketchybar item names
        # SC2206: Word splitting in array - false positive for sketchybar config arrays
        if shellcheck -x -e SC1090,SC2034,SC2154,SC2086,SC2206 "$file" 2>/dev/null; then
            echo "  ✓ shellcheck passed"
        else
            echo "  ❌ shellcheck found issues"
            ERRORS=$((ERRORS + 1))
        fi
    fi
done

echo ""
echo "Checking configuration structure..."
echo ""

# Verify key files exist
KEY_FILES=("sketchybarrc" "themes.sh" "plugins/common.sh")
for file in "${KEY_FILES[@]}"; do
    if [[ -f "$CONFIG_DIR/$file" ]]; then
        echo "✓ $file exists"
    else
        echo "❌ $file missing"
        ERRORS=$((ERRORS + 1))
    fi
done

echo ""
echo "Checking plugin sourcing..."
echo ""

# Check that plugins source common.sh or themes.sh
PLUGINS=$(find "$CONFIG_DIR/plugins" -type f -name "*.sh" ! -name "common.sh")
for plugin in $PLUGINS; do
    plugin_name=$(basename "$plugin")

    # Toggle scripts and display scripts should source common.sh
    if grep -q "source.*common\.sh" "$plugin"; then
        echo "✓ $plugin_name sources common.sh"
    elif grep -q "source.*themes\.sh" "$plugin"; then
        echo "⚠️  $plugin_name sources themes.sh directly (consider using common.sh)"
    else
        echo "❌ $plugin_name doesn't source common.sh or themes.sh"
        ERRORS=$((ERRORS + 1))
    fi
done

echo ""
echo "Checking theme configuration..."
echo ""

# Verify .theme file exists and contains valid theme
# Source themes to get the centralized list
source "$CONFIG_DIR/themes.sh"

THEME_FILE="$CONFIG_DIR/.theme"
if [[ -f "$THEME_FILE" ]]; then
    CURRENT_THEME=$(cat "$THEME_FILE")
    VALID_THEMES=$(get_theme_pattern)

    if echo "$CURRENT_THEME" | grep -qE "^($VALID_THEMES)$"; then
        echo "✓ .theme file contains valid theme: $CURRENT_THEME"
    else
        echo "❌ .theme file contains invalid theme: $CURRENT_THEME"
        ERRORS=$((ERRORS + 1))
    fi
else
    echo "⚠️  .theme file not found (will use default 'tokyo_night')"
fi

echo ""
echo "========================================"

if [[ $ERRORS -eq 0 ]]; then
    echo "✅ All validation checks passed!"
    exit 0
else
    echo "❌ Found $ERRORS error(s)"
    exit 1
fi
