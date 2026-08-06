---
description: Draft today's 200-word learning note answering the week's question. Use when Blake says "write the note", "daily note", or invokes /note.
---

# The 200-word note

One per weekday, in `notes/YYYY-MM-DD.md`. Public, in the repo. Friday's thread is assembled from the week's five notes — that's the whole point of the habit.

## Steps

1. **Get the week's question** from the SessionStart hook output.

2. **Ask Blake what he actually did and hit today.** Do not write the note from general knowledge — the note is worthless if it's a summary of documentation. The value is the specific thing that surprised him, broke, or clicked. One question: *"What surprised you today?"*

3. **Draft ~200 words** in this shape:
   - What I tried
   - What I expected
   - What actually happened
   - What I now think

4. **Write to `notes/YYYY-MM-DD.md`** with frontmatter:
   ```
   ---
   date: YYYY-MM-DD
   week: N
   question: <the week's question>
   tags: [evals, mcp, x402, ...]
   ---
   ```

5. **Show him the draft in chat** before writing the file, so he can correct the voice.

## Voice

- First person, past tense, plain.
- A specific number, error message, or file path beats an adjective.
- Say when you were wrong. "I assumed X and that was wrong because Y" is the most valuable sentence in any of these notes.
- No em-dashes as a tic. No "it's not X, it's Y." No LinkedIn openers.
- 200 words means 200 words. Cut to fit.

## What makes a bad note

Anything that could have been written without doing the work. If the note would be true for anyone who read the same docs, it's a summary, not a note — go back to step 2.
