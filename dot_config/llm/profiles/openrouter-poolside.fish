# OpenRouter: Poolside Laguna across the board. Laguna S is 1M context, XS is 256k.
source (dirname (status filename))/_openrouter.fish; or return 1
set -l s "poolside/laguna-s-2.1[1m]"
__llm_models $s $s "poolside/laguna-xs-2.1" "poolside/laguna-xs-2.1"
