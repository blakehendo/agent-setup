#!/usr/bin/env bash
# Stop hook — after 15:40 on a weekday, nudge if today's note isn't written.
# Hooks are the only hard enforcement in Claude Code. CLAUDE.md is just context.

set -euo pipefail

HOUR=$(date +%H%M)
DOW=$(date +%u)   # 1=Mon .. 7=Sun
TODAY=$(date +%Y-%m-%d)
NOTE="$CLAUDE_PROJECT_DIR/notes/${TODAY}.md"

# Weekdays only, and only after the LEARN note block starts
if [ "$DOW" -le 5 ] && [ "$HOUR" -ge 1540 ] && [ ! -f "$NOTE" ]; then
  echo "⚠️  notes/${TODAY}.md not written yet. Run /note — 200 words, then you're done."
fi

exit 0
