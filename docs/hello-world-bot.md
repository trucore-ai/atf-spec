---
title: "Hello-World Bot: Before and After ATF"
summary: Minimal bot tutorial — unprotected vs ATF-protected, showing exactly what changes when you add a policy gate.
layer: public
audience: both
status: tutorial
product_area: [onboarding, policy]
site_ref: /docs/hello-world-bot
---

# Hello-World Bot: Before and After ATF

> **Scope:** Public teaching concept. This page explains how a minimal
> autonomous bot changes when routed through ATF. The example is
> intentionally simulated and educational. It is not production trading
> advice and does not imply live public code access.
>
> **Last updated:** 2026-04-06

---

## Why a hello-world bot?

The simplest way to understand Agent Transaction Control is to see what
changes when a tiny bot adds policy enforcement to its execution flow.

A hello-world bot has one job: build a transaction intent, submit it,
and log what happened. That minimal surface makes the before/after
comparison clear without introducing unrelated complexity.

---

## Before ATF

A minimal bot without ATF follows a direct path:

```text
Bot builds transaction intent
  |
Bot submits transaction on-chain
  |
Bot logs result
```

In this flow:

- There is no policy check before execution.
- There is no verified record of why the transaction was submitted.
- If the intent violates operator rules, the bot finds out after the fact (or not at all).
- There is no fail-closed behavior. Every intent goes through.

---

## After ATF

The same bot, routed through ATF, adds a policy gate and proof layer:

```text
Bot builds transaction intent
  |
Bot sends intent to ATF (via CLI, API, or MCP)
  |
ATF evaluates policy (deterministic)
  |
Decision: allow / deny
  |
If allowed: bot receives approved intent + execution receipt
  |
Bot submits approved transaction on-chain
  |
Receipt is available for independent verification
```

What changes:

- **Policy before execution.** Every intent is evaluated against configurable
  rules before it reaches the chain.
- **Fail-closed protection.** If ATF cannot evaluate safely, the transaction
  does not proceed.
- **Proof after decision.** The bot receives a deterministic execution receipt
  that any party can verify independently.
- **Feedback into intelligence.** Over time, decision outcomes feed back into
  the Policy Intelligence Layer, improving capital deployment under operator
  control.

---

## What the bot code looks like (conceptual)

This is not runnable source code. It illustrates the structural change at
a high level.

**Before:**

```text
1. build_intent()
2. submit_transaction(intent)
3. log(result)
```

**After:**

```text
1. build_intent()
2. decision = atf_protect(intent)     # policy gate
3. if decision.status == "allow":
      submit_transaction(decision.tx)
      store(decision.receipt)          # proof
   else:
      handle_denial(decision)
4. log(result)
```

The only structural addition is the ATF policy gate at step 2 and the
receipt handling that follows. Everything else stays the same.

---

## Where this fits in the adoption journey

The hello-world bot is the entry point:

| Stage | What happens |
| --- | --- |
| **Hello-world bot** | Understand the before/after difference with a minimal example |
| **Single-agent integration** | Add ATF to a real agent or strategy via CLI, API, or MCP |
| **Multi-agent operation** | Manage multiple agents under a unified policy and receipt layer |
| **Intelligence loop** | Use the Policy Intelligence Layer to improve decisions over time |

The [Quickstart](https://trucore.xyz/quickstart) on trucore.xyz provides
a guided first-transaction experience. The hello-world bot concept here
is a companion teaching resource that explains the "why" behind that flow.

---

## Key points

- The example is simulated and educational, not production trading advice.
- ATF is non-custodial. The bot still signs and submits its own transactions.
- The receipt is deterministic and independently verifiable.
- No private repository access is required to understand this concept.

---

## Learn more

- [Policy Intelligence Layer](policy-intelligence-layer.md) -- how policy,
  proof, and feedback connect
- [MCP integration](mcp-integration.md) -- hosted MCP as one integration path
- [Architecture overview](../spec/architecture.md) -- public component flow
- [Quickstart](https://trucore.xyz/quickstart) -- try your first protected
  transaction
