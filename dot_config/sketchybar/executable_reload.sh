#!/bin/bash

# SketchyBar Reload Script
# Quick reload for testing configuration changes

echo "🔄 Reloading SketchyBar..."

# Kill existing SketchyBar process
killall sketchybar 2>/dev/null

# Wait a moment for clean shutdown
sleep 0.5

# Start SketchyBar
sketchybar &

# Wait for startup
sleep 1

echo "✅ SketchyBar reloaded successfully!"
echo ""
echo "Configuration: ~/.config/sketchybar/sketchybarrc"
echo "Plugins: ~/.config/sketchybar/plugins/"
echo ""
echo "To check status: brew services list | grep sketchybar"
