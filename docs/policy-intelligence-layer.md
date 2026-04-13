---
title: Policy Intelligence Layer (PIL)
summary: Conceptual overview — policy enforcement, verified receipts, and the feedback loop that improves capital deployment.
layer: public
audience: both
status: canonical
product_area: [policy, receipts]
---

# Policy Intelligence Layer (PIL)

> **Scope:** Public conceptual overview. This page explains PIL as the
> framing that connects policy enforcement, verified receipts, and the
> feedback loop that improves capital deployment over time. It does not
> describe internal enforcement logic or policy semantics.
>
> **Last updated:** 2026-04-06

---

## What PIL is

The Policy Intelligence Layer is the conceptual frame that ties ATF's
three core capabilities into a continuous loop:

1. **Policy before execution.** Every transaction intent is evaluated
   against configurable rules before it reaches the chain.
2. **Verified decision after execution.** A deterministic execution
   receipt provides tamper-evident proof of the decision.
3. **Feedback into intelligence.** Decision outcomes and receipt data
   feed back into the policy layer, so enforcement improves over time
   under operator control.

PIL is not a separate service. It is the name for the intelligence loop
that emerges when policy enforcement and verified receipts are connected
to a feedback mechanism.

---

## The three phases

### Phase 1: Policy enforcement

Before a transaction intent reaches the chain, ATF evaluates it against
the operator's policy configuration. The evaluation is deterministic:
the same inputs always produce the same decision.

This phase answers the question: **should this intent execute?**

### Phase 2: Verified receipt

After the policy decision, ATF produces a deterministic execution receipt.
The receipt is tamper-evident (SHA-256 content hash over JCS-canonicalized
data) and can be verified independently by any party, with no secrets or
special access required.

This phase answers the question: **what was decided, and can I prove it?**

### Phase 3: Feedback loop

Over time, the accumulation of decisions, outcomes, and receipts creates
a data surface that operators can use to refine their policies. Patterns
that lead to poor outcomes can be identified. Rules that are too
restrictive or too permissive can be adjusted.

This phase answers the question: **how do I deploy capital more
effectively over time?**

---

## How PIL connects to the product

```text
Transaction intent
  |
  v
[Phase 1] Policy enforcement  -->  allow / deny
  |
  v
[Phase 2] Verified receipt     -->  tamper-evident proof
  |
  v
On-chain execution (if allowed)
  |
  v
[Phase 3] Feedback loop        -->  outcomes inform policy
  |
  +-------> back to Phase 1 (refined policy)
```

All three phases are present in every ATF interaction. The hello-world
bot tutorial illustrates phases 1 and 2 directly. Phase 3 becomes
visible as operators accumulate decision history and adjust their
policy configuration over time.

---

## Key principles

- **Operator control.** PIL does not make autonomous adjustments. The
  feedback loop provides data and signals; operators decide what to
  change.
- **Deterministic enforcement.** Policy evaluation produces the same
  decision for the same inputs, regardless of feedback loop state. The
  feedback loop influences policy configuration, not individual
  evaluations.
- **Proof at every step.** Receipts provide verifiable evidence for
  every decision. This makes the feedback loop auditable.
- **Capital deployment improves over time.** The purpose of the loop is
  not just security. It is better allocation of resources under
  operator-defined constraints.

---

## PIL and integration surfaces

PIL operates identically regardless of how the agent integrates with ATF:

| Surface | PIL behavior |
| --- | --- |
| CLI (v1.5.1) | Same policy enforcement, same receipts, same feedback data |
| API | Same |
| Hosted MCP | Same |

The intelligence loop is a property of the enforcement engine, not the
integration path.

---

## Learn more

- [Hello-world bot concept](hello-world-bot.md) -- see PIL phases 1 and 2
  in a minimal before/after example
- [MCP integration](mcp-integration.md) -- hosted MCP as one path into
  the PIL loop
- [Architecture overview](../spec/architecture.md) -- public component flow
- [Receipt format](../spec/receipt.md) -- the receipt that anchors phase 2
- [Verification procedure](../spec/verification.md) -- independent receipt
  verification
