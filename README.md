# claude-rip

Claude Code のセッションが終了したとき、ターミナルに墓標 ASCII art を表示するプラグイン。

```
           _____________
          /             \
         /    R . I . P  \
        /                 \
       |                   |
       |   Session ended   |
       |                   |
       |     a3f2b8c1      |
       |                   |
       |  2026-04-15 14:30 |
       |                   |
       |   ░░░░░░░░░░░░░   |
       |                   |
    ___|___________________|___
   /                           \
  /   ▓▓▓▒▒▒░░░░░░░░▒▒▒▓▓▓     \
```

## Features

- `SessionEnd` フックで発火 (`/exit`, `/clear`, Ctrl+C など全て対象)
- セッション ID (先頭 8 文字) と終了時刻を表示
- bash + sed のみで動作。追加依存なし
- `/dev/tty` に直接出力 (取得できない環境では stderr)

## Installation

```
/plugin marketplace add sonicpotato08/session-rip-for-ClaudeCode
/plugin install claude-rip@carbon-claude-plugins
```

## Verify

`/exit` または `/clear` を実行して墓標が表示されることを確認。

## License

MIT
