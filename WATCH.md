# WATCH.md

Tracks material changes in the agent-payments / agent-identity landscape. Sources: ACK, AP2, x402, Catena, ACP, general news. Append-only, newest at bottom is wrong — newest heading goes on top would also be wrong; entries are chronological, one `## YYYY-MM-DD` section per day.

## 2026-08-11

First run — no prior entry to diff against, so this is a baseline snapshot of current state per source rather than a strict "last 24h" diff. Future entries will only list deltas from here.

- **ACK (agentcommercekit/ack)**: `agentcommercekit@0.11.0` released Aug 4 — credential verification now binds to prevent forgery and fails closed when a revocation check is unverifiable; JWT `aud` validation is now mandatory. This changes the trust assumptions a delegated-authority eval can rely on: a revoked credential that previously might pass now hard-fails, and tokens without a bound audience are rejected outright. **DESIGN IMPACT** — any eval fixture using unbound JWTs or simulating revocation-check timeouts needs updating to match fail-closed behavior. https://github.com/agentcommercekit/ack/releases/tag/agentcommercekit%400.11.0

- **AP2 (google-agentic-commerce/AP2)**: No commits since Apr 29 (`fix: remove uvlock`, build cleanup only). Last spec-level work was `v0.2.0` (Apr 28) adding Human-Not-Present flows. ~3.5 months of GitHub silence — noting as baseline; worth checking if AP2 governance/spec work has moved to FIDO Alliance channels rather than assuming it's stalled. https://github.com/google-agentic-commerce/AP2/releases/tag/v0.2.0

- **x402**: Governance moved from Coinbase-led to the vendor-neutral x402 Foundation (Linux Foundation), operational launch July 14 — 40 charter members including Coinbase, Circle, Stripe, Visa, Mastercard, AWS, Google. Spec itself last bumped to v2 in December 2025 (wallet-based identity, dynamic recipients, CAIP/IETF alignment). x402.org was unreachable from this environment (network proxy block); above reconstructed from Linux Foundation press release and the mirrored spec on GitHub. https://www.linuxfoundation.org/press/linux-foundation-announces-operational-launch-of-x402-foundation-to-standardize-internet-native-payments-for-ai-agents-and-applications

- **Catena (catena.com/blog)**: Unreachable — both catena.com and catenalabs.com blocked by network proxy. No reliable post-level dates found via search. Flagging as a source gap, not a "no change" result.

- **Agentic Commerce Protocol (agentic-commerce-protocol/agentic-commerce-protocol)**: Latest stable spec dated Apr 17 — added cart, feed, orders, authentication, and MCP support. Still beta, jointly maintained by OpenAI and Stripe, active dev continuing in `unreleased/`. https://github.com/agentic-commerce-protocol/agentic-commerce-protocol

- **News**: OSL AgentPay launched Aug 7 — multi-stablecoin (USDT/USDC/USDGO) agent payment infra supporting x402, AP2, and MPP simultaneously. Signals convergence pressure on evals that assume a single settlement rail. https://www.globenewswire.com/news-release/2026/08/07/3340938/0/en/osl-group-launches-osl-agentpay-multi-stablecoin-payment-infrastructure-for-ai-agents.html

- **News**: Cloudflare Wallets announced Aug 4 — spending-capped, identifiable agent wallets built on x402 rails. Relevant to delegated-authority scope: spend caps are a concrete enforcement point. https://www.explainx.ai/blog/cloudflare-wallets-ai-agent-payments-august-2026

- **News**: KYA-OS (formerly MCP-Identity) donated to the Decentralized Identity Foundation in March 2026, uses DIDs/VCs for agent identity. Baseline note, not new this week. https://knowyouragent.network/every-company-building-ai-agent-identity-in-2026

## 2026-08-12

ACK, AP2, and the Agentic Commerce Protocol (OpenAI/Stripe) repos are unchanged since Aug 11 — no new commits or releases. Catena remains unreachable (network egress block); x402.org is also now confirmed blocked from this environment. No news items found dated after Aug 11.

- **x402 (x402-foundation/x402 GitHub, not covered in the Aug 11 governance-only check)**: Active pre-release commits Aug 8–11 — a facilitator transaction-limit config PR (`feat(svm): make facilitator transaction limits operator-configurable`) plus new docs on payment flows and settle phases. No tag or release cut yet. Introduces an operator-configurable spend-cap primitive at the facilitator layer — a candidate enforcement point to watch, not yet something to build eval fixtures against since it's unreleased. https://github.com/x402-foundation/x402/pull/3128

## 2026-08-13

ACK, AP2, and the Agentic Commerce Protocol repos are unchanged since last check — no new commits or releases. Catena and x402.org remain blocked from this environment (persistent source gap, not new). No news items found dated in the last 24-48h beyond what's already logged.

- **x402 (x402-foundation/x402)**: PR #3132 merged Aug 12 — the TypeScript SVM "exact" static payment path now requires validating the TransferChecked instruction discriminator (`data[0] === 12`), closing a gap where it checked the token program at instruction index 2 but not the discriminator itself. Python, Go, and the smart-wallet path already had this check; TS was the outlier. **DESIGN IMPACT** — any eval fixture exercising SVM/Solana payment verification via the TS SDK should assume a malformed or spoofed TransferChecked instruction now fails closed, where before it may have passed. https://github.com/x402-foundation/x402/pull/3132
- **x402 (x402-foundation/x402)**: Also Aug 12 — Go SDK payment flows (#3115) and an SVM "upto" payment flow for TS (#3094), plus SVM payment scheme docs (#3135). Extends x402 settlement rails from EVM-only to Solana across Go, TS, and (already) Python. Aug 11 versioning commits (ts/python/go) suggest a release is being staged, but no tag exists yet on the Releases page — still unreleased. https://github.com/x402-foundation/x402/pull/3094

## 2026-08-14

ACK, AP2, and the Agentic Commerce Protocol repos are unchanged since last check — no new commits or releases. Catena and x402.org remain blocked from this environment (persistent source gap, not new). No news items found dated in the last 24-48h beyond what's already logged (Visa and Mastercard agent-payment items surfacing in searches are both from June 2026, already stale).

- **x402 (x402-foundation/x402)**: PR #3124 merged Aug 13 — TypeScript client now enforces default `spendControls`: unrecognized assets are capped at $1 USD unless explicitly allowlisted via `allowedAssets` (with optional per-payment atomic caps), or disabled outright with `spendControls: false`. This is a default-on client-side spend cap where none existed before. **DESIGN IMPACT** — a delegated-authority eval that assumes a TS client will sign for any requested amount on an unrecognized asset now needs to account for the $1 default ceiling, and should add fixtures that exercise `allowedAssets`/`maxAmountPerPayment` and the explicit opt-out. https://github.com/x402-foundation/x402/pull/3124
- **x402 (x402-foundation/x402)**: PR #3133 merged Aug 13 — SIWX (Sign-In-With-X) client challenges must now bind to the request origin: `createSIWxPayload` takes a required third `requestUrl` argument, and signing is refused if the challenge's `domain`/`uri` origin doesn't match. Closes a cross-origin replay gap where a signed challenge could previously be presented against a different origin. **DESIGN IMPACT** — any eval fixture calling the old 2-arg `createSIWxPayload(info, signer)` signature will break, and a same-origin-mismatch fixture that previously passed should now fail closed. https://github.com/x402-foundation/x402/pull/3133
- **x402 (x402-foundation/x402)**: PR #3153 merged Aug 14 — fixed the Monad USDC v1 EIP-712 domain name (was "USD Coin", now "USDC") in the Go/Python legacy network tables, matching the already-correct v2 tables and TS path; v1 Monad payments were failing signature recovery on-chain. Minor correctness fix, no eval design impact. https://github.com/x402-foundation/x402/pull/3153
</content>
