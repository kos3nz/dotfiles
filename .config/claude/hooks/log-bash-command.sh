#!/usr/bin/env bash
# Logs Bash commands to .claude/logs/bash-command-log.jsonl

# Check if logging option is enabled
if [[ "${LOG_BASH_COMMAND}" != "true" ]]; then
  echo "Logging bash commands disabled" >&2
  exit 0
fi

GITROOT=$(git rev-parse --show-toplevel 2>/dev/null || pwd)
RELPATH=$(git rev-parse --show-prefix 2>/dev/null)
REPO_CWD="$(basename "$GITROOT")/${RELPATH%/}"

mkdir -p "$GITROOT/.claude/logs"

jq --arg cwd_rel "$REPO_CWD" '{
  timestamp: (now | strftime("%Y-%m-%dT%H:%M:%S%z")),
  session_id: .session_id,
  command: .tool_input.command,
  description: (.tool_input.description // null),
  cwd_rel: $cwd_rel
}' >>"$GITROOT/.claude/logs/bash-command-log.jsonl"
