#!/bin/sh

X=$(limactl list | grep Running | wc -l |xargs)

# The item invoking this script (name $NAME) will get its icon and label
# updated with the current battery status
sketchybar --set "$NAME" label="VM: ${X}"
