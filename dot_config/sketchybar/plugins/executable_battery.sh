#!/bin/sh

# Battery plugin - Show wattage when charging, time remaining when discharging

PERCENTAGE="$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)"
BATTERY_INFO="$(pmset -g batt | grep InternalBattery)"

if [ "$PERCENTAGE" = "" ]; then
  exit 0
fi

# Pastel color palette
PASTEL_GREEN=0xffa6e3a1
PASTEL_YELLOW=0xfff9e2af
TEXT_DARK=0xff1e1e2e
TEXT_PRIMARY=0xffcdd6f4
BG_PRIMARY=0xff313244

# Check if discharging (not just on AC power)
if echo "$BATTERY_INFO" | grep -q "discharging"; then
  # When discharging, show time remaining with yellow background
  TIME_REMAINING="$(echo "$BATTERY_INFO" | grep -Eo "[0-9]+:[0-9]+" | head -1)"
  
  if [ "$TIME_REMAINING" != "" ]; then
    LABEL="$TIME_REMAINING"
  else
    # If time remaining not available, just show percentage
    LABEL="${PERCENTAGE}%"
  fi
  
  BG_COLOR=$PASTEL_YELLOW
  LABEL_COLOR=$TEXT_DARK
else
  # When on AC power (charging or full), show wattage with green background
  WATTS=$(system_profiler SPPowerDataType 2>/dev/null | awk '/Wattage \(W\)/ {print $3; exit}')
  
  if [ -n "$WATTS" ]; then
    LABEL="${WATTS}W"
  else
    # Fallback: try to get from ioreg AdapterDetails
    WATTS=$(ioreg -rn AppleSmartBattery | grep '"Watts"' | head -1 | awk '{print $3}')
    if [ -n "$WATTS" ]; then
      LABEL="${WATTS}W"
    else
      LABEL="${PERCENTAGE}%"
    fi
  fi
  
  BG_COLOR=$PASTEL_GREEN
  LABEL_COLOR=$TEXT_DARK
fi

sketchybar --set "$NAME" \
  icon.drawing=off \
  label="$LABEL" \
  label.font="Hack Nerd Font Mono:Medium:12.0" \
  label.color="$LABEL_COLOR" \
  label.padding_left=10 \
  label.padding_right=10 \
  background.color="$BG_COLOR"
