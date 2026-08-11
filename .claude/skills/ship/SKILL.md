---
description: Commit and push the day's work with a real commit message. Use when Blake says "ship it", "commit this", "push", or invokes /ship.
---

# Ship

The 16:30 block. Get the day's work off the machine.

## Steps

1. **Run `pwd` first.** Print it. If it is not the project directory you expect, stop and say so. Blake once ran `git init` in his home directory and staged 400,000 files. The guard is cheap.

2. **Run `git status --short`.** Show him what is staged and what is not. If the file count looks wrong, stop. Hundreds of files in a small project means something is broken.

3. **Check for secrets.** Search the diff for `sk-`, `pk-`, `API_KEY=`, `password`, and `BEGIN PRIVATE KEY`. If you find any, stop and tell him. The `.gitignore` file protects `.env`. It does not protect a key pasted into a script.

4. **Write a real commit message.** Read the diff. Do not guess from file names.
   - Write the subject line under 72 characters. Use the imperative mood.
   - Add a body only if the reason is not clear from the subject.
   - "update files" and "wip" are not commit messages.

5. **Commit and push.** Show the output.

6. **Check the daily note.** If `notes/YYYY-MM-DD.md` does not exist, say so. The note is part of shipping.

## Good and bad messages

```
bad:  update stuff
bad:  Added session-start.sh, check-note.sh, settings.json, and README changes
good: add SessionStart hook that prints current plan week
good: fix week calculation, was off by one on Mondays
```

## Rules

- Never run `git add -A` from a directory you have not checked with `pwd`.
- Never force-push without asking.
- Never commit a file from `.env`. Offer `.env.example` instead.
- Make one commit per logical change when you can.
