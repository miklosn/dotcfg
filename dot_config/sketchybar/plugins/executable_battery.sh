#!/opt/homebrew/bin/bash

source "$CONFIG_DIR/plugins/common.sh"

PERCENTAGE="$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)"
BATTERY_INFO="$(pmset -g batt | grep InternalBattery)"

if [ "$PERCENTAGE" = "" ]; then
  set_error_state "No Battery"
  exit 0
fi

if echo "$BATTERY_INFO" | grep -q "discharging"; then
  TIME_REMAINING="$(echo "$BATTERY_INFO" | grep -Eo "[0-9]+:[0-9]+" | head -1)"

  # Check for critical battery level
  if [ "$PERCENTAGE" -lt 20 ]; then
    BG_COLOR=$COLOR_ERROR
    LABEL_COLOR=0xff1e1e2e
  else
    BG_COLOR=$COLOR_WARNING
    LABEL_COLOR=0xff1e1e2e
  fi

  if [ "$TIME_REMAINING" != "" ]; then
    LABEL="$TIME_REMAINING"
  else
    LABEL="${PERCENTAGE}%"
  fi
else
  WATTS=""

  # Try system_profiler first with error handling
  if command -v system_profiler >/dev/null 2>&1; then
    WATTS=$(system_profiler SPPowerDataType 2>/dev/null | awk '/Wattage \(W\)/ {print $3; exit}')
  fi

  # Fallback to ioreg if system_profiler failed
  if [ -z "$WATTS" ] && command -v ioreg >/dev/null 2>&1; then
    WATTS=$(ioreg -rn AppleSmartBattery 2>/dev/null | grep '"Watts"' | head -1 | awk '{print $3}')
  fi

  if [ -n "$WATTS" ] && [[ "$WATTS" =~ ^[0-9]+(\.[0-9]+)?$ ]]; then
    LABEL="${WATTS}W"
  else
    LABEL="${PERCENTAGE}%"
  fi

  BG_COLOR=$COLOR_SUCCESS
  LABEL_COLOR=0xff1e1e2e
fi

set_item_colored_bg "$BG_COLOR"
sketchybar --set "$NAME" \
    icon.drawing=off \
    label="$LABEL" \
    label.color="$LABEL_COLOR" \
    label.padding_left="$TOGGLE_LABEL_PADDING_LEFT" \
    label.padding_right="$TOGGLE_LABEL_PADDING_RIGHT"
