#!/usr/bin/env bash
# One-shot migration: pull the API tokens out of 1Password and the tool configs
# into ~/.config/llm/secrets/, so the tools can read them without the 1Password CLI.
# Run this BEFORE uninstalling 1Password CLI. Safe to re-run.
set -euo pipefail

SECRETS="$HOME/.config/llm/secrets"
OPENCODE_CONFIG="$HOME/.config/opencode/opencode.json"
mkdir -p "$SECRETS"
chmod 700 "$SECRETS"

put() { # put <name> <value>
    local name="$1" value="$2"
    if [ -z "$value" ]; then
        echo "  SKIP $name (empty)"
        return
    fi
    printf '%s' "$value" > "$SECRETS/$name"
    chmod 600 "$SECRETS/$name"
    echo "  wrote $name (${#value} chars)"
}

echo "From 1Password:"
for name in openrouter hai; do
    if value=$(op read "op://Personal/$name/credential" 2>/dev/null); then
        put "$name" "$value"
    else
        echo "  SKIP $name (1Password read failed - is it unlocked?)"
    fi
done

echo "From opencode.json (Atlassian, reused by the Jira/Confluence MCP):"
if [ -f "$OPENCODE_CONFIG" ]; then
    jira=$(python3 -c "import json;print(json.load(open('$OPENCODE_CONFIG'))['mcp']['mcp-atlassian']['environment'].get('JIRA_API_TOKEN',''))" 2>/dev/null || true)
    if [ -n "$jira" ] && [[ "$jira" != '{file:'* ]]; then
        put jira "$jira"
        # Rewrite the config to point at the file. Done here, not by hand, so the
        # token is never lost between removing it from the config and saving it.
        OPENCODE_CONFIG="$OPENCODE_CONFIG" python3 - <<'PY'
import json, os
p = os.environ["OPENCODE_CONFIG"]
d = json.load(open(p))
env = d["mcp"]["mcp-atlassian"]["environment"]
ref = "{file:~/.config/llm/secrets/jira}"
env["JIRA_API_TOKEN"] = ref
if env.get("CONFLUENCE_API_TOKEN"):
    env["CONFLUENCE_API_TOKEN"] = ref
json.dump(d, open(p, "w"), indent=2)
open(p, "a").write("\n")
PY
        echo "  rewrote opencode.json to use {file:~/.config/llm/secrets/jira}"
    else
        echo "  opencode.json already references a file, skipping"
    fi
fi

echo
echo "Result:"
ls -l "$SECRETS" | tail -n +2 | awk '{print "  "$NF" ("$5" bytes, "$1")"}'
