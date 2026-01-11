#!/opt/homebrew/bin/bash

# Common styling library for SketchyBar plugins
# Source this file in plugins to reduce code duplication

# Source theme configuration
source "$CONFIG_DIR/themes.sh"

# Logging function for debugging
log_debug() {
    if [[ "${SKETCHYBAR_DEBUG:-0}" == "1" ]]; then
        echo "[DEBUG $NAME] $1" >&2
    fi
}

# Error handling function
handle_error() {
    local error_msg="$1"
    local exit_code="${2:-1}"
    log_debug "Error: $error_msg (exit code: $exit_code)"
    set_error_state "$error_msg"
    exit "$exit_code"
}

# Validate required variables
validate_env() {
    local required_vars=("$@")
    for var in "${required_vars[@]}"; do
        if [[ -z "${!var}" ]]; then
            handle_error "Required variable $var is not set" 2
        fi
    done
}

# Function to set standard item styling
set_item_style() {
    sketchybar --set "$NAME" \
        background.color="$BG_PRIMARY" \
        background.corner_radius="$CORNER_RADIUS" \
        background.height="$ITEM_HEIGHT" \
        padding_left=4 \
        padding_right=4
}

# Function to set item with custom background color
set_item_with_bg() {
    local bg_color="$1"
    sketchybar --set "$NAME" \
        background.color="$bg_color" \
        background.corner_radius="$CORNER_RADIUS" \
        background.height="$ITEM_HEIGHT" \
        padding_left=4 \
        padding_right=4
}

# Function to set item with colored background and dark text
set_item_colored_bg() {
    local bg_color="$1"
    sketchybar --set "$NAME" \
        background.color="$bg_color" \
        background.corner_radius="$CORNER_RADIUS" \
        background.height="$ITEM_HEIGHT" \
        padding_left=4 \
        padding_right=4 \
        label.color="$TEXT_DARK"
}

# Function to set icon and label colors
set_colors() {
    local icon_color="$1"
    local label_color="${2:-$TEXT_PRIMARY}"
    sketchybar --set "$NAME" \
        icon.color="$icon_color" \
        label.color="$label_color"
}

# Function to set icon and label with padding
set_icon_label() {
    local icon="$1"
    local label="$2"
    local icon_color="${3:-$TEXT_PRIMARY}"
    local label_color="${4:-$TEXT_PRIMARY}"
    
    sketchybar --set "$NAME" \
        icon="$icon" \
        icon.color="$icon_color" \
        label="$label" \
        label.color="$label_color"
}

# Function to set label only with padding
set_label_only() {
    local label="$1"
    local label_color="${2:-$TEXT_PRIMARY}"
    local bg_color="${3:-$BG_PRIMARY}"
    
    sketchybar --set "$NAME" \
        icon.drawing=off \
        label="$label" \
        label.color="$label_color" \
        label.padding_left="$TOGGLE_LABEL_PADDING_LEFT" \
        label.padding_right="$TOGGLE_LABEL_PADDING_RIGHT" \
        background.color="$bg_color"
}

# Function to set icon only
set_icon_only() {
    local icon="$1"
    local icon_color="${2:-$TEXT_PRIMARY}"
    
    sketchybar --set "$NAME" \
        icon="$icon" \
        icon.color="$icon_color" \
        label.drawing=off
}

# Function to handle common error states
set_error_state() {
    local error_msg="${1:-Error}"
    sketchybar --set "$NAME" \
        icon="󰅚" \
        icon.color="$COLOR_ERROR" \
        label="$error_msg" \
        label.color="$COLOR_ERROR"
}

# Function to handle loading states
set_loading_state() {
    local loading_msg="${1:-Loading...}"
    sketchybar --set "$NAME" \
        icon="󰔵" \
        icon.color="$COLOR_WARNING" \
        label="$loading_msg" \
        label.color="$TEXT_PRIMARY"
}