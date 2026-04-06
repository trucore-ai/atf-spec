# Agent Transaction Firewall (ATF) — Specification

![spec](https://img.shields.io/badge/spec-public-blue)
![ai-agents](https://img.shields.io/badge/ai_agents-supported-purple)
![solana](https://img.shields.io/badge/solana-compatible-green)
![execution-receipts](https://img.shields.io/badge/execution_receipts-verifiable-orange)
![developer-tooling](https://img.shields.io/badge/devtool-agent_infrastructure-lightgrey)

**Policy-enforced transaction protection for AI trading agents.**

ATF is a transaction policy enforcement layer that sits between autonomous trading bots and on-chain execution. It evaluates every transaction intent against configurable policy rules, returns a deterministic machine-readable decision, and generates tamper-evident execution receipts that any party can verify independently — no secrets or API keys required.

This repository contains the **public specification and interface contract**: receipt schema, deterministic verification procedure, threat model, and architecture overview. It is the stable reference for anyone building bot integration middleware, receipt verification tooling, or non-custodial execution guardrails on top of ATF.

> The core enforcement engine remains private. This spec provides the stable contract that integrators rely on and auditors use for independent receipt verification.

**Try ATF in under 60 seconds**
→ [Quickstart](https://trucore.xyz/quickstart) · [Protected swap example](https://trucore.xyz/examples/protected-swap)

---

## Available today

| Surface | Details |
| --- | --- |
| **CLI** | v1.5.1 -- deterministic enforcement and receipt verification from the command line |
| **Hosted MCP integration** | Five-tool surface for agent runtimes: `probe_transaction`, `simulate_transaction`, `protect_transaction`, `verify_receipt`, `explain_decision` |
| **Hello-world bot tutorial** | Before/after teaching path showing how a minimal bot changes when routed through ATF |
| **Policy Intelligence Layer (PIL)** | Policy before execution, verified receipt after decision, feedback into the intelligence loop |
| **Receipt verification** | Independent, deterministic, no secrets required |

→ [MCP integration overview](docs/mcp-integration.md) · [Hello-world bot concept](docs/hello-world-bot.md) · [Policy Intelligence Layer](docs/policy-intelligence-layer.md)

---

## Who this is for

- **Solana bot developers** adding transaction policy enforcement to automated strategies
- **Agent framework builders** integrating execution guardrails into AI trading agents
- **Autonomous trading systems** that need deterministic allow/deny decisions before execution
- **DeFi execution infrastructure teams** building non-custodial crypto algo trading infrastructure
- **Quant developers** requiring tamper-evident audit trails for autonomous trading bots

---

## What ATF does

- **Protects transaction intents before execution** — every request is evaluated against policy before reaching the chain
- **Evaluates policy rules deterministically** — same inputs always produce the same decision, enabling reproducible audits
- **Returns machine-readable decisions** — `allow`, `deny`, or `error` with structured metadata for downstream automation
- **Generates tamper-evident execution receipts** — SHA-256 content hashes over JCS-canonicalized receipt data
- **Supports receipt verification workflows** — any party can verify receipt integrity independently
- **Fits into non-custodial bot architectures** — ATF never holds keys or submits transactions on your behalf

---

## How it fits into a bot

```text
Bot / Agent
  ↓
Build transaction intent (e.g. Jupiter swap)
  ↓
ATF protect endpoint (via CLI, API, or MCP)
  ↓
Policy Intelligence Layer (PIL)
  - policy evaluation (deterministic)
  - decision + verified receipt
  - outcomes feed back into the intelligence loop
  ↓
Approved transaction + execution receipt
  ↓
Bot submits to Solana
  ↓
Receipt verification (independent, any party)
```

ATF slots into the decision layer between intent construction and on-chain submission. It works with Jupiter swap protection, custom DeFi strategies, or any Solana transaction flow that benefits from pre-execution policy enforcement. Agents can integrate via CLI, API, or the hosted MCP surface.

For a concrete before/after example, see the [Hello-world bot concept](docs/hello-world-bot.md).

---

## Quick links

| Resource | Link |
| --- | --- |
| Quickstart guide | [trucore.xyz/quickstart](https://trucore.xyz/quickstart) |
| Protected swap example | [trucore.xyz/examples/protected-swap](https://trucore.xyz/examples/protected-swap) |
| Bot integration guide | [trucore.xyz/integrations/bot](https://trucore.xyz/integrations/bot) |
| How ATF works | [trucore.xyz/how-it-works](https://trucore.xyz/how-it-works) |
| Receipt verification | [trucore.xyz/verify](https://trucore.xyz/verify) |
| OpenClaw integration | [trucore.xyz/openclaw](https://trucore.xyz/openclaw) |
| Apply for access | [trucore.xyz/atf/apply](https://trucore.xyz/atf/apply) |

---

## Where to go next

| Goal | Link |
| --- | --- |
| **Try it quickly** — protect your first transaction in minutes | [Quickstart](https://trucore.xyz/quickstart) |
| **Understand the architecture** — how ATF evaluates and returns decisions | [How it works](https://trucore.xyz/how-it-works) |
| **Integrate into a bot** — add policy enforcement to an automated strategy | [Bot integration guide](https://trucore.xyz/integrations/bot) |
| **See a working example** — end-to-end protected Jupiter swap | [Protected swap example](https://trucore.xyz/examples/protected-swap) |
| **Verify receipts** — independently confirm receipt integrity | [Receipt verification](https://trucore.xyz/verify) |
| **Explore OpenClaw integration** — AI-agent discovery and plugin surface | [OpenClaw](https://trucore.xyz/openclaw) |
| **Apply as a design partner** — early access for teams building on ATF | [Apply](https://trucore.xyz/atf/apply) |

---

## Start here

| Topic | Document |
| --- | --- |
| Your first protected trade | [`spec/examples.md`](spec/examples.md) -- receipt structure and annotated examples |
| Hello-world bot concept | [`docs/hello-world-bot.md`](docs/hello-world-bot.md) -- before/after integration story |
| How ATF works (architecture) | [`spec/architecture.md`](spec/architecture.md) -- public component overview and flow |
| MCP integration | [`docs/mcp-integration.md`](docs/mcp-integration.md) -- hosted MCP surface for agent runtimes |
| Policy Intelligence Layer | [`docs/policy-intelligence-layer.md`](docs/policy-intelligence-layer.md) -- policy, proof, and feedback loop |
| Receipt format | [`spec/receipt.md`](spec/receipt.md) -- schema, required fields, canonicalization rules |
| Verification procedure | [`spec/verification.md`](spec/verification.md) -- step-by-step deterministic verification |
| Threat model | [`spec/threat-model.md`](spec/threat-model.md) -- adversary model and security goals |
| OpenClaw plugin surface | [trucore.xyz/openclaw](https://trucore.xyz/openclaw) -- OpenClaw integration for AI agent discovery |

---

## Public repo scope

This repository contains **public specifications and architecture/trust-model material** — the stable contract that integrators and auditors rely on.

- **Live examples and runnable quickstarts** are on [trucore.xyz](https://trucore.xyz/quickstart).
- **Implementation repositories** are not part of this public surface.
- **Receipt verification** can be performed independently using only the procedure documented in this spec — no access to any other repository is required.

If you are evaluating ATF, start with the [Quickstart](https://trucore.xyz/quickstart) or the [Where to go next](#where-to-go-next) table above.

---

## Specification documents

| Document | Description |
| --- | --- |
| [`spec/receipt.md`](spec/receipt.md) | Receipt format, field definitions, and canonicalization rules |
| [`spec/verification.md`](spec/verification.md) | Deterministic verification procedure and guarantees |
| [`spec/threat-model.md`](spec/threat-model.md) | Threat model, adversary assumptions, and security goals |
| [`spec/architecture.md`](spec/architecture.md) | High-level architecture overview |
| [`spec/versioning.md`](spec/versioning.md) | Receipt versioning policy and compatibility rules |
| [`spec/examples.md`](spec/examples.md) | Annotated receipt examples for reference and testing |
| [`spec/redaction-policy.md`](spec/redaction-policy.md) | Disclosure minimization policy -- what is and is not published |
| [`docs/hello-world-bot.md`](docs/hello-world-bot.md) | Before/after bot integration teaching concept |
| [`docs/mcp-integration.md`](docs/mcp-integration.md) | Hosted MCP integration surface for agent runtimes |
| [`docs/policy-intelligence-layer.md`](docs/policy-intelligence-layer.md) | Policy Intelligence Layer: enforcement, proof, feedback |
| [`docs/latency-positive-positioning.md`](docs/latency-positive-positioning.md) | Latency-positive positioning: execution modes, evaluation terms, benchmark philosophy |
| [`FAQ.md`](FAQ.md) | Frequently asked questions |

---

## Verification scope

### What verification proves

- The receipt content has not been modified since issuance (tamper-evident integrity).
- When the original request body is provided, the receipt is bound to that specific request via cryptographic hashes (input binding).

### What verification does not prove

- **Issuer identity** — receipts are not signed in the current spec version (signing is a planned extension).
- **Execution status** — a verified receipt does not confirm that any on-chain or off-chain action was executed.
- **Policy correctness** — verification confirms integrity, not that internal enforcement logic is bug-free.

See [`spec/verification.md`](spec/verification.md) for the full procedure.

---

## Disclosure minimization

This specification intentionally omits internal enforcement logic, policy semantics, decision taxonomies, and operational details. Publishing only the receipt format and verification procedure limits the attack surface and preserves the integrity of proprietary safety controls. The public contract is sufficient for independent receipt verification and integration.

For the full policy, see [`spec/redaction-policy.md`](spec/redaction-policy.md).

---

## Compatibility

This spec is intended to match TruCore's public documentation and production behavior:
- Deterministic verification (`--verify`)
- Receipt `request_id` passthrough semantics
- Deterministic `content_hash` computed from canonicalized receipt content

If you find a mismatch between this spec and observed behavior, please open an issue.

## Developer FAQ

See [`FAQ.md`](FAQ.md) for common developer questions about ATF, execution receipts, verification, and supported platforms.

## Contributing

See [`CONTRIBUTING.md`](CONTRIBUTING.md) for scope, guidelines, and required local checks.

## Security

Please follow the disclosure process in [`SECURITY.md`](SECURITY.md).
For security reports: **security@trucore.xyz**

## License

This repository is licensed under the MIT License (docs/spec content).
See [`LICENSE`](LICENSE).

## Spec stability

The receipt format includes a `receipt_version` field following a **major.minor** scheme:

- **Minor** increments are additive and non-breaking (new optional fields, clarifications).
- **Major** increments indicate breaking changes (schema, canonicalization, or hash function changes).
- Older receipt versions remain verifiable indefinitely.

Current version: **v1.0** (stable).

See [`spec/versioning.md`](spec/versioning.md) for the full versioning policy, compatibility rules, and version history.
