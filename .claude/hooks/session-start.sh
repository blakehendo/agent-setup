#!/usr/bin/env bash
# SessionStart hook — prints where you are in the 90-day plan.
# Output goes into Claude's context, so it knows the week too.

set -euo pipefail

START="2026-08-10"
TODAY=$(date +%Y-%m-%d)

# Days since plan start (portable across macOS/Linux)
if date -j >/dev/null 2>&1; then
  S=$(date -j -f "%Y-%m-%d" "$START" +%s)          # macOS
  T=$(date -j -f "%Y-%m-%d" "$TODAY" +%s)
else
  S=$(date -d "$START" +%s)                         # Linux
  T=$(date -d "$TODAY" +%s)
fi

DAYS=$(( (T - S) / 86400 ))
WEEK=$(( DAYS / 7 + 1 ))
[ "$DAYS" -lt 0 ] && WEEK=0

case "$WEEK" in
  1) BUILD="W0 agent setup — CLAUDE.md, skills, hooks, rules, subagents, Routine, Langfuse, Promptfoo"
     LEARN="Foundations — Building Effective Agents, tool use, structured outputs, caching TTLs, effort parameter"
     Q="When is a workflow better than an agent?"
     THREAD="My agent setup, and why each piece is there" ;;
  2) BUILD="W1 agent opportunity finder — ActivityWatch, knowledgeC.db, the automation report"
     LEARN="Agent infrastructure I — Skills/SKILL.md, the 31 hook events, subagents, Routines"
     Q="Context vs. policy — why CLAUDE.md can't enforce anything"
     THREAD="I let an agent look at how I spend my time" ;;
  *) BUILD="see the 90-day plan in the project"
     LEARN="see the learn roadmap in the project"
     Q="(set this week's question)"
     THREAD="(set this week's thread)" ;;
esac

NOTE="notes/${TODAY}.md"
if [ -f "$CLAUDE_PROJECT_DIR/$NOTE" ]; then
  NOTE_STATUS="written"
else
  NOTE_STATUS="NOT YET WRITTEN"
fi

cat <<EOF
=== 90-DAY PLAN · WEEK ${WEEK} · $(date +%A", "%b\ %-d) ===
BUILD    ${BUILD}
LEARN    ${LEARN}
QUESTION ${Q}
THREAD   ${THREAD}
NOTE     ${NOTE} — ${NOTE_STATUS}
EOF
