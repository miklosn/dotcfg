# Shared OpenRouter wiring. The key is read from a file outside every tool config,
# so no password manager (and no biometric prompt) is needed to switch providers.
set -l keyfile ~/.config/llm/secrets/openrouter
if not test -r $keyfile
    echo "llm: missing $keyfile - run ~/.config/llm/populate-secrets.sh" >&2
    return 1
end
set -l key (cat $keyfile)
if test -z "$key"
    echo "llm: $keyfile is empty" >&2
    return 1
end
set -gx ANTHROPIC_AUTH_TOKEN $key
set -gx ANTHROPIC_BASE_URL "https://openrouter.ai/api"
set -gx ANTHROPIC_API_KEY ""   # must be explicitly empty
set -gx CLAUDE_CODE_SUBAGENT_MODEL inherit

# Helper: map all Claude Code aliases and force the session model.
# usage: __llm_models <fable> <opus> <sonnet> <haiku>
function __llm_models
    set -gx ANTHROPIC_DEFAULT_FABLE_MODEL  $argv[1]
    set -gx ANTHROPIC_DEFAULT_OPUS_MODEL   $argv[2]
    set -gx ANTHROPIC_DEFAULT_SONNET_MODEL $argv[3]
    set -gx ANTHROPIC_DEFAULT_HAIKU_MODEL  $argv[4]
    # settings.json pins a literal Anthropic model ID; ANTHROPIC_MODEL outranks it
    # (precedence: /model > --model > ANTHROPIC_MODEL > settings.json > ANTHROPIC_DEFAULT_MODEL)
    set -gx ANTHROPIC_MODEL $argv[1]
    # Auto-mode permission classifier: small, fast model (undocumented but present in the binary)
    set -gx CLAUDE_CODE_AUTO_MODE_MODEL "poolside/laguna-xs-2.1"
    # pi coding agent follows the same profile. It wants the bare OpenRouter id,
    # so strip Claude Code's [1m] context suffix. The key is not passed here:
    # ~/.pi/agent/models.json resolves it from 1Password at request time.
    set -gx PI_PROVIDER openrouter
    set -gx PI_MODEL (string replace -r '\[1m\]$' '' $argv[1])
end
