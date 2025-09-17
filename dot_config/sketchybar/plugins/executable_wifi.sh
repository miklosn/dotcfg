#!/bin/sh

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

# Set label and color based on connection status
if [ "$CURRENT_NETWORK" = "<redacted>" ] || [[ "$CURRENT_NETWORK" == *"redacted"* ]]; then
  # If we get redacted, just show WiFi icon with "Connected" status
  WIFI_STATUS=$(networksetup -getairportpower en0 2>/dev/null | grep "On")
  if [ -n "$WIFI_STATUS" ]; then
    LABEL="Connected"
    COLOR=0xff48c774  # Green for connected
    ICON=
  else
    LABEL="Off"
    COLOR=0xff8e8e93  # Gray for off
    ICON=󰤮
  fi
elif [ -z "$CURRENT_NETWORK" ]; then
  # Check if WiFi is off or just no network
  WIFI_STATUS=$(networksetup -getairportpower en0 2>/dev/null | grep "On")
  if [ -z "$WIFI_STATUS" ]; then
    LABEL="Off"
    COLOR=0xff8e8e93  # Gray for off
    ICON=󰤮
  else
    LABEL="No Network"
    COLOR=0xffffcc00  # Yellow/amber for no network
    ICON=󰤫
  fi
else
  # Truncate long network names
  if [ ${#CURRENT_NETWORK} -gt 15 ]; then
    LABEL="${CURRENT_NETWORK:0:12}..."
  else
    LABEL="$CURRENT_NETWORK"
  fi
  COLOR=0xff48c774  # Green for connected
  ICON=
fi

# Update the item with label, color, and icon
sketchybar --set "$NAME" label="$LABEL" background.color="$COLOR" icon="$ICON"