#!/opt/homebrew/bin/bash


source "$CONFIG_DIR/plugins/common.sh"


# Validate required environment
validate_env "CONFIG_DIR"

# Count running VMs with error handling
if ! command -v limactl >/dev/null 2>&1; then
    handle_error "limactl not found"
fi

X=$(limactl list 2>/dev/null | grep -c Running | xargs)

if [ -z "$X" ]; then
    X=0
fi

# Set color based on VM count
if [ "$X" -gt 0 ]; then
  LABEL_COLOR=$TEXT_DARK
  BG_COLOR=$COLOR_SUCCESS
else
  LABEL_COLOR=$TEXT_PRIMARY
  BG_COLOR=$BG_PRIMARY
fi

set_label_only "VM:$X" "$LABEL_COLOR" "$BG_COLOR"
