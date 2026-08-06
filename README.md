# agent-setup

How I run AI agents. Public on purpose — this is the substrate for a 90-day build plan, and the setup itself is the first artifact.

I'm a product manager, not an engineer. I don't write the code; I drive agents that do. This repo is what that looks like when you take it seriously.

## What's here

```
CLAUDE.md                    Persistent instructions. Under 200 lines on purpose.
.claude/
  settings.json              Hook registration
  hooks/
    session-start.sh         Prints where I am in the 90-day plan, every session
    check-note.sh            Nags me if the daily note isn't written by end of day
  skills/
    big3/SKILL.md            /big3   — the morning ritual
    note/SKILL.md            /note   — today's 200-word learning note
    thread/SKILL.md          /thread — assemble the week's X thread from the notes
  rules/
    python.md               Loads only when a .py file is touched (paths: frontmatter)
  agents/
    skeptic.md              Adversarial reviewer. Tries to refute, not confirm.
    spec-scout.md           Reads protocol specs, returns what a PM needs to decide.
promptfooconfig.yaml         First eval: can models pick the right payment rail?
notes/                       One 200-word note per weekday
BIG3.md                      Daily Big 3, appended each morning
.env.example                 Langfuse OTel config
```

## Why each piece

**CLAUDE.md under 200 lines.** Long instruction files *reduce* adherence and cost tokens on every single turn. Anything that became a procedure moved into a skill, where it loads lazily.

**`.claude/rules/` with `paths:` frontmatter.** Rules load only when Claude touches a matching file. The Python conventions cost nothing on the 90% of turns that aren't Python.

**Hooks, not instructions.** CLAUDE.md is context — the model can ignore it. Hooks are the only hard enforcement in Claude Code. There are 31 hook events. If something must happen, it's a hook.

**Skills, not slash commands.** Those merged. `.claude/skills/note/SKILL.md` gives you `/note`, plus a directory for supporting files and frontmatter controlling when the model invokes it on its own.

**Subagents with narrow jobs.** `skeptic` is prompted to refute rather than confirm, and defaults to "refuted" under uncertainty — because an agent asked to check work will otherwise agree with it. `spec-scout` returns what a PM decides on, not what an implementer builds from.

**Langfuse via OpenTelemetry.** Claude Code emits OTel natively from the CLI. Six environment variables, no SDK, no code, free tier. Every tool call and subagent delegation shows up as one trace.

**Promptfoo, not Braintrust.** Promptfoo is YAML. That means the eval is a config file I can read, review, and put in a pull request — the same artifact shape as acceptance criteria. Braintrust is better tooling if an engineer owns the harness. I own the harness.

## Setup

```bash
git clone <this repo> && cd agent-setup
chmod +x .claude/hooks/*.sh
cp .env.example .env    # fill in Langfuse keys, then: source .env
claude                  # the SessionStart hook should print the current week
npx promptfoo@latest eval && npx promptfoo@latest view
```

## The plan this supports

12 weeks, Aug 10 – Oct 30 2026. BUILD 2.5h/day, LEARN 2h/day, one thread a week.

1. Agent setup (this repo)
2. Agent opportunity finder — what should I automate?
3–6. n-of-1 health experiment engine — randomized, not correlational
7. For Sale LLM arena — six models, 500 games
8–12. Delegated authority conformance suite — how often does an agent spend money it wasn't authorized to spend?
