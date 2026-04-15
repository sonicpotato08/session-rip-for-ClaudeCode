#!/usr/bin/env bash
# claude-rip: SessionStart で開始時刻を記録する

set -u

INPUT=$(cat 2>/dev/null || true)
SESSION_ID=$(printf '%s' "$INPUT" \
  | sed -n 's/.*"session_id"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' \
  | head -1)

[[ -z "$SESSION_ID" ]] && exit 0

STATE_DIR="${TMPDIR:-/tmp}"
date '+%m-%d %H:%M' > "${STATE_DIR%/}/claude-rip-${SESSION_ID}.start" 2>/dev/null || true

exit 0
