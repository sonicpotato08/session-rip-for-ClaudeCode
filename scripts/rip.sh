#!/usr/bin/env bash
# claude-rip: SessionEnd で墓標を表示する

set -u

INPUT=$(cat 2>/dev/null || true)
SESSION_ID=$(printf '%s' "$INPUT" \
  | sed -n 's/.*"session_id"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' \
  | head -1)
REASON=$(printf '%s' "$INPUT" \
  | sed -n 's/.*"reason"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' \
  | head -1)

# /clear は TUI 即時再描画とレースして表示が崩れるのでスキップ
if [[ "$REASON" == "clear" ]]; then
  exit 0
fi

SHORT_ID="${SESSION_ID:0:8}"
[[ -z "$SHORT_ID" ]] && SHORT_ID="????????"

DIED=$(date '+%m-%d %H:%M')

# 開始時刻を読み込み (SessionStart で書かれたもの)
STATE_DIR="${TMPDIR:-/tmp}"
STATE_FILE="${STATE_DIR%/}/claude-rip-${SESSION_ID}.start"
BORN="??-?? ??:??"
if [[ -n "$SESSION_ID" && -r "$STATE_FILE" ]]; then
  BORN=$(head -1 "$STATE_FILE" 2>/dev/null || echo "??-?? ??:??")
  rm -f "$STATE_FILE"
fi

# 出力先: /dev/tty が開ければそこへ、なければ stderr へ
if (: > /dev/tty) 2>/dev/null; then
  OUT=/dev/tty
else
  OUT=/dev/stderr
fi

cat > "$OUT" <<EOF

           _____________
          /             \\
         /    R . I . P  \\
        /                 \\
       |                   |
       |   Session ended   |
       |                   |
       |     ${SHORT_ID}      |
       |                   |
       | Born: ${BORN} |
       | Died: ${DIED} |
       |                   |
       |   ░░░░░░░░░░░░░   |
       |                   |
    ___|___________________|___
   /                           \\
  /   ▓▓▓▒▒▒░░░░░░░░▒▒▒▓▓▓     \\

EOF

exit 0
