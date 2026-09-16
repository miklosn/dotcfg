# Hyperspace (hai): Sonnet 4.6 as the main model, Haiku 4.5 in the sonnet slot
# because the auto-mode permission classifier runs on that slot.
source (dirname (status filename))/_hai.fish; or return 1
__hai_models "anthropic--claude-4.6-sonnet[1m]" "anthropic--claude-4.6-sonnet[1m]" "anthropic--claude-4.5-haiku" "anthropic--claude-4.5-haiku"
