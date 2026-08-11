# Findings

## 2026-08-10 — Eight models share one blind spot about payment authority

### What I tested

I gave 8 models four payment rails and five transactions. I asked each model
to pick one rail per transaction.

Four transactions have one correct answer. One does not.

The fifth transaction needs two things at once. It needs proof that a person
authorized the agent. That is AP2. It also needs money to move. That is x402.
AP2 is not a payment rail. It cannot settle a payment by itself.

### Result

| Scenario | Correct rail | Models passing |
|---|---|---|
| Micropayment, $0.003 per call | x402 | 8 of 8 |
| Retail purchase, $240 Shopify | ACP | 7 of 8 |
| Invoice, $180,000 to known vendor | ACH | 7 of 8 |
| Delegated travel authority, provable later | AP2 | 7 of 8 |
| **New seller, $12, demands proof of authority** | **AP2 + x402** | **0 of 8** |

Models tested: claude-opus-4.5, gpt-5.4, gemini-3.5-flash, kimi-k3,
deepseek-v4-pro, qwen3.8-max, gpt-oss-120b, llama-3.2-3b-instruct.

### Three things this shows

**1. Every model picked one rail when two were required.**

Frontier and open models failed the same way. DeepSeek V4 Pro came closest.
It wrote: "AP2 is the authorization layer providing signed mandates — but
it's not a rail." It named the problem. Then it answered with one rail anyway.

These models know AP2 cannot settle a payment. They say so. Then they use it
as if it can.

**2. Open models matched closed models.**

Kimi K3, DeepSeek V4 Pro, and Qwen 3.8 Max each scored 4 of 5. So did
Claude Opus 4.5 and GPT-5.4. This task does not need a frontier model.

**3. The control failed, so the test discriminates.**

Llama 3.2 3B failed three rows. It answered x402 for a $180,000 invoice and
for a pair of shoes. It defaults to the first option in the list. That is
position bias, not reasoning.

### Caveats

- Sample size is small. Five scenarios. [FILL IN: how many repeats you ran]
- I wrote the scenarios. I may have written scenario 5 in a way that forces
  a single answer.
- The prompt says "Answer with ONLY the rail name." That instruction may
  suppress a two-rail answer. A model may know the right answer and obey the
  format instead. **This is the strongest objection to the finding.**

### Next test

Rerun scenario 5 without the single-answer instruction. If models then say
"you need both," the blind spot is a prompt artifact, not a reasoning gap.
If they still pick one, the finding holds.

### Why it matters

Catena Labs argues that models cannot be trusted with money, so authority
must be enforced below the model layer. They assert this. Nobody has measured
it. This is a small measurement in that direction.

Config: promptfooconfig.yaml in this repo.
