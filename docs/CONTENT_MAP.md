# ATF Documentation Content Map

> Where to find every type of ATF documentation.

This map covers all three surfaces in the ATF knowledge system.
Each entry links to the canonical location for that content type.

---

## Specification & Formal Reference

These documents define the stable contract that integrators and auditors
rely on. They are normative.

| Document | Location | Description |
|----------|----------|-------------|
| Architecture overview | [spec/architecture.md](../spec/architecture.md) | Components, flow, design principles |
| Receipt schema | [spec/receipt.md](../spec/receipt.md) | JCS + SHA-256 receipt format (normative) |
| Verification procedure | [spec/verification.md](../spec/verification.md) | 5-step deterministic verification |
| Threat model | [spec/threat-model.md](../spec/threat-model.md) | Zero-trust assumptions, adversaries, goals |
| Versioning policy | [spec/versioning.md](../spec/versioning.md) | Major.minor receipt version scheme |
| Redaction policy | [spec/redaction-policy.md](../spec/redaction-policy.md) | What is published vs withheld |
| Examples | [spec/examples.md](../spec/examples.md) | Illustrative receipt JSON |

---

## Concepts & Integration

Conceptual overviews for developers evaluating or integrating ATF.

| Document | Location | Description |
|----------|----------|-------------|
| MCP integration | [docs/mcp-integration.md](mcp-integration.md) | Hosted MCP surface overview |
| Hello-world bot | [docs/hello-world-bot.md](hello-world-bot.md) | Before/after ATF integration concept |
| Policy Intelligence Layer | [docs/policy-intelligence-layer.md](policy-intelligence-layer.md) | PIL: enforce → receipt → feedback |
| FAQ | [FAQ.md](../FAQ.md) | Common questions and answers |

---

## Product Documentation (TruCore-site)

Human-facing and agent-facing documentation lives at
[trucore.xyz/docs](https://trucore.xyz/docs).

| Topic | URL | Description |
|-------|-----|-------------|
| Getting started | [/docs/getting-started](https://trucore.xyz/docs/getting-started) | Signup, API key, first trade |
| First protected trade | [/docs/first-protected-trade](https://trucore.xyz/docs/first-protected-trade) | Golden path walkthrough |
| CLI reference | [/docs/cli](https://trucore.xyz/docs/cli) | Complete CLI documentation |
| API reference | [/docs/api](https://trucore.xyz/docs/api) | Public API endpoints |
| Integration surfaces | [/docs/surfaces](https://trucore.xyz/docs/surfaces) | API vs CLI vs MCP vs OpenClaw |
| Receipts & trust | [/docs/receipts-and-trust](https://trucore.xyz/docs/receipts-and-trust) | What receipts prove |
| Plans & tiers | [/docs/plans](https://trucore.xyz/docs/plans) | Free, Pro, Enterprise |
| Agent discovery | [/docs/agent-discovery](https://trucore.xyz/docs/agent-discovery) | Machine-readable ATF manifest |
| OpenClaw plugin | [/docs/openclaw-plugin](https://trucore.xyz/docs/openclaw-plugin) | @trucore/trucore-atf plugin docs |

---

## Where to go for what

| "I need to…" | Go to |
|--------------|-------|
| Understand what ATF is | This repo's [README](../README.md) or [trucore.xyz/atf](https://trucore.xyz/atf) |
| Verify a receipt independently | [spec/verification.md](../spec/verification.md) |
| Integrate ATF into my bot | [trucore.xyz/docs/getting-started](https://trucore.xyz/docs/getting-started) |
| Understand the receipt format | [spec/receipt.md](../spec/receipt.md) |
| See CLI commands | [trucore.xyz/docs/cli/commands](https://trucore.xyz/docs/cli/commands) |
| Use MCP tools | [docs/mcp-integration.md](mcp-integration.md) |
| Report a security issue | [SECURITY.md](../SECURITY.md) |
| Contribute to the spec | [CONTRIBUTING.md](../CONTRIBUTING.md) |
| Get operational support | [trucore.xyz/docs](https://trucore.xyz/docs) (authenticated) |

---

## Documentation layers

ATF documentation follows a three-layer model:

1. **Public layer** (this repo + trucore.xyz/docs) — Discovery, specification,
   and integration guidance. Readable by anyone including AI agents.
2. **Authenticated layer** (trucore.xyz, behind product auth) — Operational
   guides, customer-specific workflows, troubleshooting. Requires an account.
3. **Internal layer** (private repo) — Engineering truth, security details,
   deployment procedures, performance data. Team access only.

The specification in this repo is the normative source for receipt format,
verification procedure, and threat model. Product documentation on
trucore.xyz provides tutorials and operational guidance built on top of
these specifications.
