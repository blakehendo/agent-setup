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
</content>
