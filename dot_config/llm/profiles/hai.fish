# Hyperspace (hai): cheapest Claude everywhere. Haiku 4.5 is 200k context.
source (dirname (status filename))/_hai.fish; or return 1
set -l h "anthropic--claude-4.5-haiku"
__hai_models $h $h $h $h
