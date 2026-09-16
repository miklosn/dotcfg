# OpenRouter: Z.ai GLM flash (1M context) for fable/opus/haiku, Laguna XS for sonnet (auto-mode classifier runs on the sonnet slot)
source (dirname (status filename))/_openrouter.fish; or return 1
set -l m "~z-ai/glm-flash-latest[1m]"
__llm_models $m $m "poolside/laguna-xs-2.1" $m
