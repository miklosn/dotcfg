# SketchyBar Configuration

Clean, modular SketchyBar setup with 11 themes and consistent design.

## Quick Start

```bash
./reload.sh                              # Reload configuration
./switch_theme.sh nord                   # Switch theme
./set_font.sh "JetBrainsMono Nerd Font Mono"  # Change font
./validate.sh                            # Validate configuration
```

## Available Themes

13 carefully curated themes - each visually distinct and purposeful:

- `tokyo_night` - Modern blue-purple dark (default)
- `mocha` - Warm lavender dark (Catppuccin)
- `gruvbox` - Retro warm brown-orange
- `nord` - Cool minimal arctic blue  
- `dracula` - High contrast purple-pink
- `rose_pine` - Low contrast muted pastels
- `one_dark` - VSCode professional
- `everforest` - Comfortable greenish nature
- `kanagawa` - Japanese aesthetic
- `ayu_dark` - Minimalist orange
- `moonfly` - Deep midnight blue
- `latte` - Catppuccin warm light
- `solarized_light` - Scientific light theme

## Available Fonts

Common Nerd Fonts (install with `brew install --cask font-<name>-nerd-font`):

- `Hack Nerd Font Mono` (default)
- `JetBrainsMono Nerd Font Mono`
- `FiraCode Nerd Font Mono`
- `IBMPlexMono Nerd Font Mono`
- `CaskaydiaCove Nerd Font Mono`
- `Meslo Nerd Font Mono`

Switch fonts: `./set_font.sh "IBMPlexMono Nerd Font Mono"`

## Adding a New Plugin

### 1. Create Plugin File

```bash
cp plugin_template.sh plugins/my_plugin.sh
chmod +x plugins/my_plugin.sh
```

### 2. Write Plugin Logic

```bash
#!/opt/homebrew/bin/bash

source "$CONFIG_DIR/plugins/common.sh"

# Your logic here
VALUE=$(your_command)

# Use helper functions from common.sh
set_item_style
sketchybar --set "$NAME" \
    icon="󰊓" \
    icon.color="$COLOR_INFO" \
    label="$VALUE" \
    label.color="$TEXT_PRIMARY"
```

### 3. Add to sketchybarrc

```bash
sketchybar --add item my_plugin right \
           --set my_plugin \
                 update_freq=10 \
                 icon.color=$ACCENT_BLUE \
                 label.color=$TEXT_PRIMARY \
                 background.color=$BG_PRIMARY \
                 background.corner_radius=6 \
                 background.height=26 \
                 padding_left=4 \
                 padding_right=4 \
                 script="$PLUGIN_DIR/my_plugin.sh"
```

### 4. Reload

```bash
./reload.sh
```

## Common Helper Functions

Use these from `common.sh`:

```bash
set_item_style                              # Standard background
set_item_colored_bg "$COLOR"                # Colored background
set_label_only "$TEXT" "$COLOR" "$BG"       # Label-only item
set_icon_label "$ICON" "$LABEL" ...         # Icon + label
set_error_state "Error message"             # Error display
set_loading_state "Loading..."              # Loading display
```

## Available Theme Colors

Access these in your plugins:

```bash
$COLOR_SUCCESS    # Green - running, connected, good
$COLOR_ERROR      # Red - stopped, failed, critical  
$COLOR_WARNING    # Yellow - caution, medium
$COLOR_INFO       # Blue - information, normal
$COLOR_SPECIAL    # Purple - special, accent

$TEXT_PRIMARY     # Main text
$TEXT_SECONDARY   # Dimmed text
$TEXT_INACTIVE    # Inactive text
$BG_PRIMARY       # Item background
$BG_SECONDARY     # Secondary background
```

## Creating Interactive Plugins

### Click Actions

```bash
# In sketchybarrc
click_script="$PLUGIN_DIR/my_toggle.sh"

# In my_toggle.sh
#!/opt/homebrew/bin/bash

source "$CONFIG_DIR/plugins/common.sh"

# Toggle logic
if pgrep myapp; then
    killall myapp
else
    open -a "MyApp"
fi

# Force refresh
"$CONFIG_DIR"/plugins/my_plugin.sh
```

## Event-Driven Updates

```bash
# In sketchybarrc - create custom event
sketchybar --add event my_event

# Subscribe plugin to event
--subscribe my_plugin my_event

# In any plugin - trigger event
sketchybar --trigger my_event
```

## Adding a New Theme

Add to `themes.sh` in the `load_theme()` function:

```bash
"my_theme")
    BAR_COLOR="0xe01e1e2e"
    BG_PRIMARY="0xff313244"
    BG_SECONDARY="0xff45475a"
    TEXT_PRIMARY="0xffcdd6f4"
    TEXT_SECONDARY="0xffa6adc8"
    TEXT_INACTIVE="0xff6c7086"
    TEXT_DARK="0xff1e1e2e"
    COLOR_SUCCESS="0xffa6e3a1"
    COLOR_ERROR="0xfff38ba8"
    COLOR_WARNING="0xfff9e2af"
    COLOR_INFO="0xff89b4fa"
    COLOR_SPECIAL="0xffcba6f7"
    ;;
```

Update validation in `switch_theme.sh` and `validate.sh`, then: `./switch_theme.sh my_theme`

## Troubleshooting

**Bar not showing**
```bash
brew services restart sketchybar
```

**Icons not displaying**
```bash
brew install --cask font-hack-nerd-font
brew services restart sketchybar
```

**Plugin not updating**
```bash
chmod +x ~/.config/sketchybar/plugins/*.sh
./validate.sh
```

**Check logs**
```bash
tail -f /tmp/sketchybar.log
```
