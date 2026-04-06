# Frequently Asked Questions

## What does receipt verification prove?

Verification confirms that a receipt has not been modified since issuance (tamper-evident integrity). When the original request body is also provided, verification additionally confirms the receipt is bound to that specific request via cryptographic hashes.

Verification does **not** prove who issued the receipt, whether the underlying action was executed, or that the engine's internal reasoning was correct.

See [spec/verification.md](spec/verification.md) for the full procedure and guarantees.

## Does this repo include the ATF core enforcement engine?

No. This repository contains only the public specification: receipt schema, deterministic verification procedure, threat model, and architecture overview. The core enforcement engine remains private by design.

See [README.md](README.md) for details.

## Can I build a receipt verifier from this spec?

Yes. The verification procedure is fully specified in [spec/verification.md](spec/verification.md) and requires no secrets, API keys, or access to the ATF engine. Any party can independently verify receipt integrity using the documented canonicalization (JCS / RFC 8785) and hash computation steps (SHA-256).

## Are receipts cryptographically signed?

Not in the current spec version. Receipts are tamper-evident via deterministic `content_hash` (SHA-256 of JCS-canonicalized content). Cryptographic signing is a planned optional extension that can be layered without changing the core verification contract.

See [spec/architecture.md](spec/architecture.md) for roadmap notes.

## Is receipt verification proof of on-chain execution?

No. A verified receipt proves only that the receipt content has not been altered since issuance. It does not prove that any on-chain or off-chain action was executed. Execution proofs and on-chain attestation are separate concerns, noted in the architecture roadmap as potential future extensions.

## How does the spec evolve?

The receipt format includes a `receipt_version` field. Changes follow a **major.minor** versioning scheme: minor versions are additive and non-breaking; major versions indicate breaking schema or canonicalization changes. Older versions remain verifiable indefinitely.

See [spec/versioning.md](spec/versioning.md) for the full versioning policy.

## Why are engine internals omitted from this repo?

This specification follows a disclosure-minimization approach. Publishing only the verification contract and receipt format reduces the attack surface, limits adversarial pre-study of enforcement logic, and preserves the integrity of proprietary safety mechanisms. The public spec is sufficient for independent verification and integration without requiring access to internal details.

## Where do I report security issues?

Follow the private disclosure process in [SECURITY.md](SECURITY.md). Email **security@trucore.xyz** with a description of the issue. Do not open public GitHub issues for security vulnerabilities.

## Can I use this spec in my own project?

This repository is licensed under the MIT License. You may reference and use the specification content according to the license terms. See [LICENSE](LICENSE).

## How do I know this spec matches production behavior?

The spec is intended to match TruCore's public documentation and production behavior. If you find a mismatch between this spec and observed behavior, please open an issue. See the Compatibility section in [README.md](README.md).

---

## What is the Agent Transaction Firewall (ATF)?

ATF is a policy-enforcement layer between an AI agent or trading bot and blockchain transaction execution. Bots submit transaction intents to ATF, which evaluates policies before execution and generates a deterministic execution receipt.

## How does ATF protect AI trading agents?

Agents route transaction intents through ATF before execution. ATF evaluates policy rules and returns an approved transaction along with a verifiable execution receipt.

## Is ATF custodial?

No. ATF does not custody funds or keys. Agents sign and submit transactions independently.

## What are execution receipts?

Execution receipts are deterministic records that allow developers to verify how a transaction was evaluated and approved.

## How can developers verify receipts?

Receipts can be independently checked using the [receipt verification tool](https://trucore.xyz/verify).

## What blockchains does ATF support?

ATF is currently designed around Solana-based execution flows and autonomous trading agents operating on DeFi protocols.

## Does ATF work with trading bots or AI agents?

Yes. ATF is designed for:

- AI trading agents
- Autonomous trading bots
- Crypto algo trading systems
- DeFi automation frameworks

## Where can I try ATF?

- [Quickstart](https://trucore.xyz/quickstart)
- [Protected swap example](https://trucore.xyz/examples/protected-swap)
- [Bot integration guide](https://trucore.xyz/integrations/bot)

## Does ATF add latency to my bot?

ATF introduces enforcement overhead, but the direction is **latency-positive enforcement**: ATF's shared state and parallel processing can reduce total workflow latency compared to a standalone bot doing the same work independently. See [`docs/latency-positive-positioning.md`](docs/latency-positive-positioning.md) for the product direction.

## What is the current CLI version?

The current CLI version is **v1.5.1**. The CLI supports deterministic enforcement and receipt verification from the command line.

## What is MCP and how does ATF use it?

MCP (Model Context Protocol) is a standardized way for AI agent runtimes to discover and invoke external tools. ATF exposes a hosted MCP surface with five tools: `probe_transaction`, `simulate_transaction`, `protect_transaction`, `verify_receipt`, and `explain_decision`. MCP is one integration path alongside the CLI and direct API. See [`docs/mcp-integration.md`](docs/mcp-integration.md) for more.

## What is the Policy Intelligence Layer (PIL)?

PIL is the conceptual frame that connects ATF's three core capabilities: policy enforcement before execution, verified receipts after decisions, and a feedback loop that improves capital deployment over time under operator control. It is not a separate service. See [`docs/policy-intelligence-layer.md`](docs/policy-intelligence-layer.md) for the full overview.

## What is the hello-world bot example?

The hello-world bot is a teaching concept that shows how a minimal autonomous bot changes when routed through ATF. It illustrates the before/after difference: an unprotected direct flow versus a policy-gated flow with fail-closed protection and proof. The example is simulated and educational. See [`docs/hello-world-bot.md`](docs/hello-world-bot.md).

## How many ways can I integrate with ATF?

ATF currently offers three integration surfaces: the CLI (v1.5.1), the direct API, and a hosted MCP integration. All three lead to the same enforcement engine and produce the same deterministic receipts.
