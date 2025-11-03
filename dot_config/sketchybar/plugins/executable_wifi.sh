#!/bin/sh

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

# Pastel color palette for background
PASTEL_GREEN=0xffa6e3a1
PASTEL_YELLOW=0xfff9e2af
PASTEL_GRAY=0xffa6adc8
TEXT_DARK=0xff1e1e2e

# Set label and background color based on connection status
if [ "$CURRENT_NETWORK" = "<redacted>" ] || [[ "$CURRENT_NETWORK" == *"redacted"* ]]; then
  # If we get redacted, just show "Connected" status
  WIFI_STATUS=$(networksetup -getairportpower en0 2>/dev/null | grep "On")
  if [ -n "$WIFI_STATUS" ]; then
    LABEL="Connected"
    BG_COLOR=$PASTEL_GREEN
  else
    LABEL="WiFi Off"
    BG_COLOR=$PASTEL_GRAY
  fi
elif [ -z "$CURRENT_NETWORK" ]; then
  # Check if WiFi is off or just no network
  WIFI_STATUS=$(networksetup -getairportpower en0 2>/dev/null | grep "On")
  if [ -z "$WIFI_STATUS" ]; then
    LABEL="WiFi Off"
    BG_COLOR=$PASTEL_GRAY
  else
    LABEL="Searching"
    BG_COLOR=$PASTEL_YELLOW
  fi
else
  # Connected to a network - show SSID (truncate if too long)
  if [ ${#CURRENT_NETWORK} -gt 12 ]; then
    LABEL="${CURRENT_NETWORK:0:10}.."
  else
    LABEL="$CURRENT_NETWORK"
  fi
  BG_COLOR=$PASTEL_GREEN
fi

sketchybar --set "$NAME" \
  icon.drawing=off \
  label="$LABEL" \
  label.font="Hack Nerd Font Mono:Medium:12.0" \
  label.color=$TEXT_DARK \
  label.padding_left=10 \
  label.padding_right=10 \
  background.color=$BG_COLOR
