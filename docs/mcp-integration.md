# MCP Integration

> **Scope:** Public overview of ATF's hosted MCP integration surface.
> This page describes what MCP provides, the available tool set, and
> how it fits alongside other integration paths. It does not contain
> implementation-level setup instructions.
>
> **Last updated:** 2026-04-06

---

## What MCP is for

MCP (Model Context Protocol) provides a standardized way for AI agent
runtimes to discover and invoke external tools. ATF exposes a hosted MCP
surface so that agent frameworks can integrate policy enforcement and
receipt verification without building custom protocol adapters.

MCP is one integration path into ATF. It sits alongside the CLI and direct
API as equally supported surfaces. Teams choose the path that best fits
their agent runtime and deployment model.

---

## Hosted MCP surface

ATF's MCP integration is hosted. Agent runtimes connect to the TruCore
MCP endpoint and receive access to the full tool set. There is no
self-hosted MCP server to deploy or maintain.

---

## Tool set

The current MCP surface exposes exactly five tools:

| Tool | Purpose |
| --- | --- |
| `probe_transaction` | Check whether a transaction intent would be allowed under current policy, without executing |
| `simulate_transaction` | Run a full policy simulation and return the projected decision and metadata |
| `protect_transaction` | Submit a transaction intent for policy evaluation and receive an approved intent with execution receipt |
| `verify_receipt` | Verify the integrity of a previously issued execution receipt |
| `explain_decision` | Retrieve a human-readable explanation of a policy decision |

All five tools operate within ATF's existing security model: deterministic
enforcement, fail-closed behavior, and tamper-evident receipts.

---

## How MCP fits into the integration landscape

```text
Agent runtime
  |
  +-- CLI (v1.5.1)          -- command-line integration
  +-- API                    -- direct programmatic access
  +-- MCP (hosted)           -- tool-based integration for agent frameworks
       |
       +-- probe_transaction
       +-- simulate_transaction
       +-- protect_transaction
       +-- verify_receipt
       +-- explain_decision
```

All three paths lead to the same enforcement engine and produce the same
deterministic receipts. The choice between them depends on the agent's
runtime environment, not on differences in security or capability.

---

## When to use MCP

MCP is a good fit when:

- The agent runtime already supports MCP tool discovery (e.g. Model Context
  Protocol-compatible frameworks).
- The team wants tool-based integration without building a custom client.
- Multiple tools (probe, simulate, protect, verify, explain) are needed
  within the same agent session.

The CLI or direct API may be simpler when the integration is a single
protect-and-verify call from a script or cron job.

---

## What MCP does not change

- ATF remains non-custodial. MCP tools do not sign or submit transactions.
- Receipts are the same format and verification procedure regardless of
  integration path.
- Policy evaluation is deterministic across all surfaces.

---

## Learn more

- [Hello-world bot concept](hello-world-bot.md) -- see how a minimal bot
  integrates with ATF
- [Policy Intelligence Layer](policy-intelligence-layer.md) -- policy,
  proof, and feedback loop
- [Architecture overview](../spec/architecture.md) -- public component flow
- [Receipt verification](../spec/verification.md) -- deterministic
  verification procedure
