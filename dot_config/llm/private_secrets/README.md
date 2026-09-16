# LLM + API tokens

One file per token, each holding only the raw value (no newline, no quotes).
Directory is `700`, files are `600`.

This directory is the single source for tokens, kept deliberately *outside* every
tool's config so that `~/.pi/agent/models.json`, `~/.config/opencode/opencode.json`
and friends contain paths rather than secrets.

| File | Used by |
|---|---|
| `openrouter` | `llm openrouter-*` fish profiles, pi's `openrouter` provider |
| `hai` | `llm hai`, `llm hai-sonnet`, pi's `hai` provider |
| `jira` | opencode's `mcp-atlassian` (both the Jira and Confluence tokens) |

How each consumer reads it:

- fish profiles: `set -l key (cat ~/.config/llm/secrets/<name>)`
- pi: `"apiKey": "!cat ~/.config/llm/secrets/<name>"` in `~/.pi/agent/models.json`
- opencode: `"{file:~/.config/llm/secrets/jira}"` in `~/.config/opencode/opencode.json`

Populate or refresh with `~/.config/llm/populate-secrets.sh`.

Note: anything that reaches the internet from this machine can read these files, and
they are not encrypted at rest. That is an accepted trade for portability into VMs
where a password manager is unavailable. If this directory is ever synced or backed
up, treat the backup as containing live credentials.
