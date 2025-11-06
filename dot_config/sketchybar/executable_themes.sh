#!/opt/homebrew/bin/bash

if [[ -z "$CONFIG_DIR" ]]; then
    if [[ -n "${BASH_SOURCE[0]}" ]]; then
        CONFIG_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    else
        CONFIG_DIR="$HOME/.config/sketchybar"
    fi
fi

# Single source of truth for available themes
AVAILABLE_THEMES=(tokyo_night mocha gruvbox nord dracula rose_pine one_dark everforest kanagawa ayu_dark moonfly latte solarized_light)

# Theme display names (associative array)
declare -A THEME_NAMES=(
    [tokyo_night]="Tokyo Night"
    [mocha]="Mocha"
    [gruvbox]="Gruvbox"
    [nord]="Nord"
    [dracula]="Dracula"
    [rose_pine]="Rose Pine"
    [one_dark]="One Dark"
    [everforest]="Everforest"
    [kanagawa]="Kanagawa"
    [ayu_dark]="Ayu Dark"
    [moonfly]="Moonfly"
    [latte]="Latte"
    [solarized_light]="Solarized Light"
)

# Get theme display name
get_theme_name() {
    local theme="$1"
    echo "${THEME_NAMES[$theme]:-$theme}"
}

# Get theme list as regex pattern for validation
get_theme_pattern() {
    local IFS="|"
    echo "${AVAILABLE_THEMES[*]}"
}

# Get theme list as array (for iteration)
get_themes() {
    echo "${AVAILABLE_THEMES[@]}"
}

THEME_FILE="$CONFIG_DIR/.theme"
if [[ -f "$THEME_FILE" ]]; then
    THEME="$(cat "$THEME_FILE")"
else
    THEME="${THEME:-tokyo_night}"
fi

load_theme() {
    local theme="$1"

    case "$theme" in
        "tokyo_night")
            # Modern blue-purple dark - balanced, contemporary
            BAR_COLOR="0xe01a1b26"
            BG_PRIMARY="0xff24283b"
            BG_SECONDARY="0xff414868"
            TEXT_PRIMARY="0xffa9b1d6"
            TEXT_SECONDARY="0xff9aa5ce"
            TEXT_INACTIVE="0xff565f89"
            TEXT_DARK="0xff1a1b26"
            # Accent colors for normal UI elements
            ACCENT_PRIMARY="0xff7aa2f7"    # Blue - main accent
            ACCENT_SECONDARY="0xffbb9af7"  # Purple - secondary accent
            # Semantic colors for states
            COLOR_SUCCESS="0xff9ece6a"
            COLOR_ERROR="0xfff7768e"
            COLOR_WARNING="0xffe0af68"
            COLOR_INFO="0xff7aa2f7"
            COLOR_SPECIAL="0xffbb9af7"
            ;;
        "mocha")
            # Catppuccin Mocha - warm lavender dark
            BAR_COLOR="0xe01e1e2e"
            BG_PRIMARY="0xff313244"
            BG_SECONDARY="0xff45475a"
            TEXT_PRIMARY="0xffcdd6f4"
            TEXT_SECONDARY="0xffa6adc8"
            TEXT_INACTIVE="0xff6c7086"
            TEXT_DARK="0xff1e1e2e"
            ACCENT_PRIMARY="0xffcba6f7"    # Mauve - signature lavender
            ACCENT_SECONDARY="0xff89b4fa"  # Blue - secondary
            COLOR_SUCCESS="0xffa6e3a1"
            COLOR_ERROR="0xfff38ba8"
            COLOR_WARNING="0xfff9e2af"
            COLOR_INFO="0xff89b4fa"
            COLOR_SPECIAL="0xffcba6f7"
            ;;
        "gruvbox")
            # Retro warm brown-orange dark
            BAR_COLOR="0xe0282828"
            BG_PRIMARY="0xff3c3836"
            BG_SECONDARY="0xff504945"
            TEXT_PRIMARY="0xffebdbb2"
            TEXT_SECONDARY="0xffd5c4a1"
            TEXT_INACTIVE="0xff665c54"
            TEXT_DARK="0xff282828"
            ACCENT_PRIMARY="0xfffabd2f"    # Yellow-orange - signature warm
            ACCENT_SECONDARY="0xfffe8019"  # Bright orange
            COLOR_SUCCESS="0xffb8bb26"
            COLOR_ERROR="0xfffb4934"
            COLOR_WARNING="0xfffabd2f"
            COLOR_INFO="0xff83a598"
            COLOR_SPECIAL="0xffd3869b"
            ;;
        "nord")
            # Cool minimal arctic blue
            BAR_COLOR="0xe02e3440"
            BG_PRIMARY="0xff3b4252"
            BG_SECONDARY="0xff434c5e"
            TEXT_PRIMARY="0xffeceff4"
            TEXT_SECONDARY="0xffd8dee9"
            TEXT_INACTIVE="0xff4c566a"
            TEXT_DARK="0xff2e3440"
            ACCENT_PRIMARY="0xff88c0d0"    # Frost cyan - signature arctic
            ACCENT_SECONDARY="0xff81a1c1"  # Frost blue
            COLOR_SUCCESS="0xffa3be8c"
            COLOR_ERROR="0xffbf616a"
            COLOR_WARNING="0xffebcb8b"
            COLOR_INFO="0xff81a1c1"
            COLOR_SPECIAL="0xffb48ead"
            ;;
        "dracula")
            # High contrast dramatic purple-pink
            BAR_COLOR="0xe0282a36"
            BG_PRIMARY="0xff44475a"
            BG_SECONDARY="0xff6272a4"
            TEXT_PRIMARY="0xfff8f8f2"
            TEXT_SECONDARY="0xff6272a4"
            TEXT_INACTIVE="0xff44475a"
            TEXT_DARK="0xff282a36"
            ACCENT_PRIMARY="0xffbd93f9"    # Purple - signature dramatic
            ACCENT_SECONDARY="0xffff79c6"  # Pink
            COLOR_SUCCESS="0xff50fa7b"
            COLOR_ERROR="0xffff5555"
            COLOR_WARNING="0xfff1fa8c"
            COLOR_INFO="0xff8be9fd"
            COLOR_SPECIAL="0xffbd93f9"
            ;;
        "rose_pine")
            # Low contrast muted pastels - cozy, eye-friendly
            BAR_COLOR="0xe0191724"
            BG_PRIMARY="0xff1f1d2e"
            BG_SECONDARY="0xff26233a"
            TEXT_PRIMARY="0xffe0def4"
            TEXT_SECONDARY="0xff908caa"
            TEXT_INACTIVE="0xff6e6a86"
            TEXT_DARK="0xff191724"
            ACCENT_PRIMARY="0xffeb6f92"    # Rose - signature pink
            ACCENT_SECONDARY="0xffc4a7e7"  # Iris - purple
            COLOR_SUCCESS="0xff9ccfd8"     # Foam - muted cyan
            COLOR_ERROR="0xffeb6f92"       # Rose
            COLOR_WARNING="0xfff6c177"     # Gold
            COLOR_INFO="0xff31748f"        # Pine - muted teal
            COLOR_SPECIAL="0xffc4a7e7"     # Iris
            ;;
        "one_dark")
            # VSCode One Dark - modern, professional
            BAR_COLOR="0xe0282c34"
            BG_PRIMARY="0xff3e4451"
            BG_SECONDARY="0xff4b5263"
            TEXT_PRIMARY="0xffabb2bf"
            TEXT_SECONDARY="0xff5c6370"
            TEXT_INACTIVE="0xff4b5263"
            TEXT_DARK="0xff282c34"
            ACCENT_PRIMARY="0xff61afef"    # Blue - signature VSCode
            ACCENT_SECONDARY="0xffc678dd"  # Purple
            COLOR_SUCCESS="0xff98c379"
            COLOR_ERROR="0xffe06c75"
            COLOR_WARNING="0xffe5c07b"
            COLOR_INFO="0xff61afef"
            COLOR_SPECIAL="0xffc678dd"
            ;;
        "everforest")
            # Everforest - comfortable greenish theme
            BAR_COLOR="0xe02d353b"
            BG_PRIMARY="0xff343f44"
            BG_SECONDARY="0xff3d484d"
            TEXT_PRIMARY="0xffd3c6aa"
            TEXT_SECONDARY="0xff859289"
            TEXT_INACTIVE="0xff4f585e"
            TEXT_DARK="0xff2d353b"
            ACCENT_PRIMARY="0xffa7c080"    # Green - nature signature
            ACCENT_SECONDARY="0xff7fbbb3"  # Aqua
            COLOR_SUCCESS="0xffa7c080"
            COLOR_ERROR="0xffe67e80"
            COLOR_WARNING="0xffdbbc7f"
            COLOR_INFO="0xff7fbbb3"
            COLOR_SPECIAL="0xffd699b6"
            ;;
        "kanagawa")
            # Kanagawa - Japanese aesthetic
            BAR_COLOR="0xe01f1f28"
            BG_PRIMARY="0xff2a2a37"
            BG_SECONDARY="0xff363646"
            TEXT_PRIMARY="0xffdcd7ba"
            TEXT_SECONDARY="0xff938aa9"
            TEXT_INACTIVE="0xff54546d"
            TEXT_DARK="0xff1f1f28"
            ACCENT_PRIMARY="0xff7e9cd8"    # Blue - Japanese wave
            ACCENT_SECONDARY="0xff957fb8"  # Purple
            COLOR_SUCCESS="0xff98bb6c"
            COLOR_ERROR="0xffe82424"
            COLOR_WARNING="0xffe6c384"
            COLOR_INFO="0xff7e9cd8"
            COLOR_SPECIAL="0xffd27e99"
            ;;
        "ayu_dark")
            # Ayu Dark - minimalist with orange accent
            BAR_COLOR="0xe00a0e14"
            BG_PRIMARY="0xff0f131a"
            BG_SECONDARY="0xff1f2430"
            TEXT_PRIMARY="0xffb3b1ad"
            TEXT_SECONDARY="0xff626a73"
            TEXT_INACTIVE="0xff3e4b59"
            TEXT_DARK="0xff0a0e14"
            ACCENT_PRIMARY="0xffffaa00"    # Orange - signature minimalist
            ACCENT_SECONDARY="0xff39bae6"  # Bright blue
            COLOR_SUCCESS="0xffbae67e"
            COLOR_ERROR="0xffd95757"
            COLOR_WARNING="0xffffaa00"
            COLOR_INFO="0xff59c2ff"
            COLOR_SPECIAL="0xffd4bfff"
            ;;
        "moonfly")
            # Moonfly - deep blue midnight with bright accents
            BAR_COLOR="0xe0080808"
            BG_PRIMARY="0xff1c1c1c"
            BG_SECONDARY="0xff373c40"
            TEXT_PRIMARY="0xffbdbdbd"
            TEXT_SECONDARY="0xff9e9e9e"
            TEXT_INACTIVE="0xff4e4e4e"
            TEXT_DARK="0xff080808"
            ACCENT_PRIMARY="0xff80a0ff"    # Bright blue - signature midnight
            ACCENT_SECONDARY="0xffc099ff"  # Violet
            COLOR_SUCCESS="0xff8cc85f"
            COLOR_ERROR="0xfff74782"
            COLOR_WARNING="0xffe3d18a"
            COLOR_INFO="0xff80a0ff"
            COLOR_SPECIAL="0xffc099ff"
            ;;
        "latte")
            # Catppuccin Latte - warm light theme
            BAR_COLOR="0xe0eff1f5"
            BG_PRIMARY="0xffccd0da"
            BG_SECONDARY="0xffbcc0cc"
            TEXT_PRIMARY="0xff4c4f69"
            TEXT_SECONDARY="0xff5c5f77"
            TEXT_INACTIVE="0xffacb0be"
            TEXT_DARK="0xffeff1f5"
            ACCENT_PRIMARY="0xff8839ef"    # Mauve - signature lavender
            ACCENT_SECONDARY="0xff1e66f5"  # Blue
            COLOR_SUCCESS="0xff40a02b"
            COLOR_ERROR="0xffd20f39"
            COLOR_WARNING="0xffdf8e1d"
            COLOR_INFO="0xff1e66f5"
            COLOR_SPECIAL="0xff8839ef"
            ;;
        "solarized_light")
            # Scientific light theme - engineered for eye comfort
            BAR_COLOR="0xe0fdf6e3"
            BG_PRIMARY="0xffeee8d5"
            BG_SECONDARY="0xff93a1a1"
            TEXT_PRIMARY="0xff073642"
            TEXT_SECONDARY="0xff586e75"
            TEXT_INACTIVE="0xff93a1a1"
            TEXT_DARK="0xff002b36"
            ACCENT_PRIMARY="0xff268bd2"    # Blue - signature solarized
            ACCENT_SECONDARY="0xff2aa198"  # Cyan
            COLOR_SUCCESS="0xff859900"
            COLOR_ERROR="0xffdc322f"
            COLOR_WARNING="0xffb58900"
            COLOR_INFO="0xff268bd2"
            COLOR_SPECIAL="0xffd33682"
            ;;
        *)
            # Default to tokyo_night
            BAR_COLOR="0xe01a1b26"
            BG_PRIMARY="0xff24283b"
            BG_SECONDARY="0xff414868"
            TEXT_PRIMARY="0xffa9b1d6"
            TEXT_SECONDARY="0xff9aa5ce"
            TEXT_INACTIVE="0xff565f89"
            TEXT_DARK="0xff1a1b26"
            ACCENT_PRIMARY="0xff7aa2f7"
            ACCENT_SECONDARY="0xffbb9af7"
            COLOR_SUCCESS="0xff9ece6a"
            COLOR_ERROR="0xfff7768e"
            COLOR_WARNING="0xffe0af68"
            COLOR_INFO="0xff7aa2f7"
            COLOR_SPECIAL="0xffbb9af7"
            ;;
    esac
}

load_theme "$THEME"

export BAR_COLOR
export BG_PRIMARY
export BG_SECONDARY
export TEXT_PRIMARY
export TEXT_SECONDARY
export TEXT_INACTIVE
export TEXT_DARK
export ACCENT_PRIMARY
export ACCENT_SECONDARY
export COLOR_SUCCESS
export COLOR_ERROR
export COLOR_WARNING
export COLOR_INFO
export COLOR_SPECIAL

# Layout & Spacing (not themed - consistency is key)
export ITEM_HEIGHT=26
export CORNER_RADIUS=6
export BLUR_RADIUS=30
export SHADOW_ENABLED="off"

export ICON_PADDING_LEFT=10
export ICON_PADDING_RIGHT=4
export LABEL_PADDING_LEFT=4
export LABEL_PADDING_RIGHT=10

export TOGGLE_ICON_PADDING_LEFT=8
export TOGGLE_ICON_PADDING_RIGHT=8
export TOGGLE_LABEL_PADDING_LEFT=10
export TOGGLE_LABEL_PADDING_RIGHT=10

export PASTEL_GREEN=0xff9ec49f

# Typography - read from .font file or use default
FONT_FILE="$CONFIG_DIR/.font"
if [[ -f "$FONT_FILE" ]]; then
    FONT_FACE="$(cat "$FONT_FILE")"
else
    FONT_FACE="${SKETCHYBAR_FONT:-Hack Nerd Font Mono}"
fi

export FONT_FACE
export FONT_ICON="${FONT_FACE}:Bold:14.0"
export FONT_LABEL="${FONT_FACE}:Bold:12.0"
export FONT_SEPARATOR="${FONT_FACE}:Regular:14.0"

switch_theme() {
    local new_theme="$1"

    case "$new_theme" in
        "tokyo_night"|"mocha"|"gruvbox"|"nord"|"dracula"|"rose_pine"|"solarized_light")
            ;;
        *)
            echo "Error: Unknown theme '$new_theme'"
            echo ""
            echo "Available themes:"
            echo "  tokyo_night    - Modern blue-purple dark (default)"
            echo "  mocha          - Warm lavender dark (Catppuccin)"
            echo "  gruvbox        - Retro warm brown-orange"
            echo "  nord           - Cool minimal arctic blue"
            echo "  dracula        - High contrast purple-pink"
            echo "  rose_pine      - Low contrast muted pastels"
            echo "  solarized_light - Scientific light theme"
            return 1
            ;;
    esac

    export THEME="$new_theme"
    load_theme "$new_theme"

    echo "$new_theme" > "$THEME_FILE" 2>/dev/null || {
        echo "Warning: Could not save theme to $THEME_FILE"
    }

    echo "Theme switched to $new_theme"
}

list_themes() {
    echo "Available themes:"
    echo ""
    for theme in "${AVAILABLE_THEMES[@]}"; do
        if [[ "$THEME" == "$theme" ]]; then
            echo "  ✓ $theme (current)"
        else
            echo "    $theme"
        fi
    done
}
