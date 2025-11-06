#!/opt/homebrew/bin/bash


source "$CONFIG_DIR/plugins/common.sh"

# WiFi plugin - Text-based design with SSID and pastel background colors

# Try multiple methods to get current WiFi SSID
# Method 1: Using airport command
CURRENT_NETWORK=$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I 2>/dev/null | awk '/ SSID:/ {print $2}')

# Method 2: Using ipconfig if method 1 fails
if [ -z "$CURRENT_NETWORK" ] || [ "$CURRENT_NETWORK" = "<redacted>" ]; then
  CURRENT_NETWORK=$(ipconfig getsummary en0 2>/dev/null | grep "SSID" | awk -F': ' '{print $2}')
fi

# Method 3: Using networksetup
if [ -z "$CURRENT_NETWORK" ] || [ "$CURRENT_NETWORK" = "<redacted>" ]; then
  CURRENT_NETWORK=$(networksetup -getairportnetwork en0 2>/dev/null | sed 's/Current Wi-Fi Network: //' | grep -v "You are not associated")
fi

# Set label and background color based on connection status
if [ "$CURRENT_NETWORK" = "<redacted>" ] || [[ "$CURRENT_NETWORK" == *"redacted"* ]]; then
  # If we get redacted, just show "Connected" status
  WIFI_STATUS=$(networksetup -getairportpower en0 2>/dev/null | grep "On")
  if [ -n "$WIFI_STATUS" ]; then
    # Test actual connectivity
    if ping -c 1 -W 2000 8.8.8.8 >/dev/null 2>&1; then
      set_label_only "Connected" $TEXT_DARK $COLOR_SUCCESS
    else
      set_label_only "No Internet" $TEXT_DARK $COLOR_ERROR
    fi
  else
    set_label_only "WiFi Off" $TEXT_DARK $TEXT_SECONDARY
  fi
elif [ -z "$CURRENT_NETWORK" ]; then
  # Check if WiFi is off or just no network
  WIFI_STATUS=$(networksetup -getairportpower en0 2>/dev/null | grep "On")
  if [ -z "$WIFI_STATUS" ]; then
    set_label_only "WiFi Off" $TEXT_DARK $TEXT_SECONDARY
  else
    # Test connectivity even when no SSID
    if ping -c 1 -W 2000 8.8.8.8 >/dev/null 2>&1; then
      set_label_only "Connected" $TEXT_DARK $COLOR_SUCCESS
    else
      set_label_only "Searching" $TEXT_DARK $COLOR_WARNING
    fi
  fi
else
  # Connected to a network - test actual connectivity
  if ping -c 1 -W 2000 8.8.8.8 >/dev/null 2>&1; then
    # Connected with internet - show SSID (truncate if too long)
    if [ ${#CURRENT_NETWORK} -gt 12 ]; then
      LABEL="${CURRENT_NETWORK:0:10}.."
    else
      LABEL="$CURRENT_NETWORK"
    fi
    set_label_only "$LABEL" $TEXT_DARK $PASTEL_GREEN
  else
    # Connected to network but no internet
    if [ ${#CURRENT_NETWORK} -gt 12 ]; then
      LABEL="${CURRENT_NETWORK:0:10}.."
    else
      LABEL="$CURRENT_NETWORK"
    fi
    set_label_only "$LABEL" $TEXT_DARK $COLOR_WARNING
  fi
fi
