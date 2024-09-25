#!/bin/sh

X=$(system_profiler SPPowerDataType | grep Wattage | awk '{print $3}')

PERCENTAGE="$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)"
CHARGING="$(pmset -g batt | grep 'AC Power')"

if [ "$PERCENTAGE" = "" ]; then
  exit 0
fi

LABEL="${PERCENTAGE}%"
if [ "${X}" -gt 0 ]; then
  LABEL="${X}W"
fi

ICON="󰚦"

if [[ "$CHARGING" != "" ]]; then
  ICON=""
fi

# The item invoking this script (name $NAME) will get its icon and label
# updated with the current battery status
sketchybar --set "$NAME" icon="$ICON" label="${LABEL}"
