# Shared Hyperspace (SAP hai LLM proxy) wiring. The key is read from a file outside
# every tool config, so no password manager (and no biometric prompt) is needed.
# The proxy's Anthropic-compatible route serves Claude models only; the LiteLLM /
# OpenAI routes (used by pi) reach the cheaper non-Claude models.
set -l keyfile ~/.config/llm/secrets/hai
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
set -gx ANTHROPIC_BASE_URL "http://localhost:6655/anthropic"
set -gx ANTHROPIC_API_KEY ""   # must be explicitly empty
set -gx CLAUDE_CODE_SUBAGENT_MODEL inherit

# Helper: map all Claude Code aliases and force the session model.
# usage: __hai_models <fable> <opus> <sonnet> <haiku>
function __hai_models
    set -gx ANTHROPIC_DEFAULT_FABLE_MODEL  $argv[1]
    set -gx ANTHROPIC_DEFAULT_OPUS_MODEL   $argv[2]
    set -gx ANTHROPIC_DEFAULT_SONNET_MODEL $argv[3]
    set -gx ANTHROPIC_DEFAULT_HAIKU_MODEL  $argv[4]
    # settings.json pins a literal Anthropic model ID; ANTHROPIC_MODEL outranks it
    set -gx ANTHROPIC_MODEL $argv[1]
    # Auto-mode permission classifier: cheapest model, keeps shell reviews affordable
    set -gx CLAUDE_CODE_AUTO_MODE_MODEL "anthropic--claude-4.5-haiku"
    # pi follows the same profile via its own hai provider (LiteLLM route).
    set -gx PI_PROVIDER hai
    # string replace exits non-zero when the pattern does not match, which would
    # make the whole profile look like a failed activation. Assign via a temp.
    set -l bare_model (string replace -r '\[1m\]$' '' $argv[1])
    set -gx PI_MODEL $bare_model
    # A non-matching `string replace` exits non-zero, and that status leaks out
    # of this function, making the whole profile look like a failed activation.
    return 0
end
