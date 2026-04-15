#!/usr/bin/env bash
# claude-rip: SessionEnd で墓標を表示する

set -u

# stdin から JSON を受け取り session_id を抽出 (jq非依存)
INPUT=$(cat 2>/dev/null || true)
SESSION_ID=$(printf '%s' "$INPUT" \
  | sed -n 's/.*"session_id"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' \
  | head -1)

SHORT_ID="${SESSION_ID:0:8}"
[[ -z "$SHORT_ID" ]] && SHORT_ID="????????"

TIMESTAMP=$(date '+%Y-%m-%d %H:%M')

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
       |  ${TIMESTAMP} |
       |                   |
       |   ░░░░░░░░░░░░░   |
       |                   |
    ___|___________________|___
   /                           \\
  /   ▓▓▓▒▒▒░░░░░░░░▒▒▒▓▓▓     \\

EOF

exit 0
