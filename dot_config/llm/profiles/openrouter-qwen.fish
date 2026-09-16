# OpenRouter: Qwen 3.8 flash (1M context) for fable/opus/haiku, Laguna XS for sonnet (auto-mode classifier runs on the sonnet slot)
source (dirname (status filename))/_openrouter.fish; or return 1
set -l m "qwen/qwen3.8-flash[1m]"
__llm_models $m $m "poolside/laguna-xs-2.1" $m
