#!/opt/homebrew/bin/bash


source "$CONFIG_DIR/plugins/common.sh"

# OrbStack plugin - Text-based design with pastel background colors

if pgrep -x "OrbStack" > /dev/null; then
    set_label_only "Orb" $TEXT_DARK $COLOR_SUCCESS
else
    set_label_only "Orb" $TEXT_PRIMARY $BG_PRIMARY
fi
