#!/bin/bash

# Plugin Template - Standardized SketchyBar Plugin
# Source theme configuration
source "$CONFIG_DIR/themes.sh"

# Plugin-specific configuration
PLUGIN_NAME="${NAME:-$(basename "$0" .sh)}"
UPDATE_FREQ="${UPDATE_FREQ:-0}"
ICON_PADDING_LEFT="${ICON_PADDING_LEFT:-10}"
ICON_PADDING_RIGHT="${ICON_PADDING_RIGHT:-4}"
LABEL_PADDING_LEFT="${LABEL_PADDING_LEFT:-4}"
LABEL_PADDING_RIGHT="${LABEL_PADDING_RIGHT:-10}"

# Default colors (can be overridden by plugin logic)
ICON_COLOR_DEFAULT="$ACCENT_BLUE"
LABEL_COLOR_DEFAULT="$TEXT_PRIMARY"
BG_COLOR_DEFAULT="$BG_PRIMARY"

# Logging function for debugging
log_debug() {
    if [[ "${DEBUG:-0}" == "1" ]]; then
        echo "[$PLUGIN_NAME] $*" >&2
    fi
}

# Error handling
handle_error() {
    local error_msg="$1"
    log_debug "Error: $error_msg"
    exit 1
}

# Validate input
validate_input() {
    local input="$1"
    local validation_type="$2"
    
    case "$validation_type" in
        "number")
            if ! [[ "$input" =~ ^[0-9]+$ ]]; then
                handle_error "Invalid number: $input"
            fi
            ;;
        "non_empty")
            if [[ -z "$input" ]]; then
                handle_error "Empty input not allowed"
            fi
            ;;
    esac
}

# Standard output function
render_item() {
    local icon="$1"
    local label="$2"
    local icon_color="${3:-$ICON_COLOR_DEFAULT}"
    local label_color="${4:-$LABEL_COLOR_DEFAULT}"
    local bg_color="${5:-$BG_COLOR_DEFAULT}"
    local drawing_icon="${6:-on}"
    
    # Build sketchybar command
    local cmd=(--set "$PLUGIN_NAME")
    
    if [[ "$drawing_icon" == "off" ]]; then
        cmd+=(icon.drawing=off)
    else
        cmd+=(icon="$icon" icon.color="$icon_color")
        cmd+=(icon.font="$FONT_ICON")
        cmd+=(icon.padding_left="$ICON_PADDING_LEFT")
        cmd+=(icon.padding_right="$ICON_PADDING_RIGHT")
    fi
    
    if [[ -n "$label" ]]; then
        cmd+=(label="$label" label.color="$label_color")
        cmd+=(label.font="$FONT_LABEL")
        cmd+=(label.padding_left="$LABEL_PADDING_LEFT")
        cmd+=(label.padding_right="$LABEL_PADDING_RIGHT")
    else
        cmd+=(label.drawing=off)
    fi
    
    cmd+=(background.color="$bg_color")
    cmd+=(background.corner_radius=6)
    cmd+=(background.height=26)
    
    log_debug "Rendering: icon='$icon' label='$label'"
    
    sketchybar "${cmd[@]}"
}

# Function to get semantic color based on status
get_status_color() {
    local status="$1"
    
    case "$status" in
        "good"|"success"|"active"|"running"|"on")
            echo "$ACCENT_GREEN"
            ;;
        "warning"|"moderate"|"medium")
            echo "$ACCENT_YELLOW"
            ;;
        "error"|"critical"|"off"|"inactive")
            echo "$ACCENT_RED"
            ;;
        "info"|"accent"|"focus")
            echo "$ACCENT_BLUE"
            ;;
        "neutral"|"disabled"|"muted")
            echo "$TEXT_SECONDARY"
            ;;
        *)
            echo "$ICON_COLOR_DEFAULT"
            ;;
    esac
}

# Function to truncate text
truncate_text() {
    local text="$1"
    local max_length="${2:-20}"
    
    if [[ ${#text} -gt $max_length ]]; then
        echo "${text:0:$((max_length - 2))}.."
    else
        echo "$text"
    fi
}

# Export functions for use in plugins
export -f log_debug handle_error validate_input render_item get_status_color truncate_text