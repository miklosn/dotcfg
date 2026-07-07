#!/bin/bash
# Custom file suggestion script for Claude Code
# Uses fd + fzf for fuzzy matching

# Parse JSON input to get query
QUERY=$(jq -r '.query // ""')

# Use project dir from env, fallback to pwd
PROJECT_DIR="${CLAUDE_PROJECT_DIR:-.}"

# Bail out if project dir is home directory to avoid scanning millions of files
if [ "$PROJECT_DIR" = "$HOME" ] || { [ "$PROJECT_DIR" = "." ] && [ "$PWD" = "$HOME" ]; }; then
  exit 0
fi

# cd into project dir so rg outputs relative paths
cd "$PROJECT_DIR" || exit 1

fd --type f --hidden --max-depth 8 . 2>/dev/null | fzf --filter "$QUERY" | head -15
