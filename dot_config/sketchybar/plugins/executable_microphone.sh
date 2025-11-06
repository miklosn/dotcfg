#!/opt/homebrew/bin/bash


source "$CONFIG_DIR/plugins/common.sh"

# Microphone plugin - Show input volume level and mute status

# Get input volume (0-100) with error handling
INPUT_VOLUME=$(osascript -e 'input volume of (get volume settings)' 2>/dev/null)
OSASCRIPT_EXIT_CODE=$?

# Check if microphone exists and get status
if [ -z "$INPUT_VOLUME" ] || [ "$OSASCRIPT_EXIT_CODE" -ne 0 ]; then
  # No input device available or osascript failed
  set_error_state "No Mic"
else
  # Determine icon and color based on input volume
  if [ "$INPUT_VOLUME" -eq 0 ]; then
    # Muted
    set_icon_label "󰍭" "Muted" $COLOR_ERROR $TEXT_PRIMARY
  elif [ "$INPUT_VOLUME" -le 30 ]; then
    # Low volume
    set_icon_label "󰍬" "${INPUT_VOLUME}%" $TEXT_SECONDARY $TEXT_PRIMARY
  elif [ "$INPUT_VOLUME" -le 70 ]; then
    # Medium volume
    set_icon_label "󰍬" "${INPUT_VOLUME}%" $COLOR_INFO $TEXT_PRIMARY
  else
    # High volume
    set_icon_label "󰍬" "${INPUT_VOLUME}%" $COLOR_SUCCESS $TEXT_PRIMARY
  fi
fi
