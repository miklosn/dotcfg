# OpenRouter: DeepSeek for fable/opus/haiku slots, Poolside for sonnet.
# [1m] tells Claude Code the real 1M context window (unknown models default to 200k).
source (dirname (status filename))/_openrouter.fish; or return 1
set -l ds "deepseek/deepseek-v4-flash-0731[1m]"
__llm_models $ds $ds "poolside/laguna-xs-2.1" $ds
