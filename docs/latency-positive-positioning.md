# Latency-Positive Positioning — Product Direction

> **Scope:** Public conceptual overview. This document describes ATF's latency-positive
> direction at spec/positioning level. For implementation strategy and engineering
> detail, see the [canonical strategy document](https://github.com/trucore-ai/agent-transaction-firewall/blob/main/docs/strategy/latency_positive_atf.md)
> in the ATF implementation repo.
>
> **Last updated:** 2026-03-16

---

## Direction

ATF is evolving from a transaction enforcement layer into a **latency-positive
execution layer** for autonomous trading agents.

The goal: protected bots should be faster than unprotected bots doing the same
work alone — not merely "secure at acceptable overhead."

---

## Why This Matters

Autonomous trading agents compete on execution speed. Any infrastructure layer
perceived as adding latency faces adoption resistance, regardless of safety value.

The conventional question — "how much overhead does the firewall add?" — measures
the wrong thing. The better question:

> **Does a protected agent complete its workflow faster or slower than an
> unprotected agent doing the same work independently?**

Because ATF serves multiple agents, it can share work that standalone bots duplicate:
state reads, quote fetching, route validation, simulation. When shared work savings
exceed enforcement overhead, the net effect is latency-positive.

---

## Execution Modes (Directional)

ATF is exploring three conceptual execution modes that govern the tradeoff between
enforcement freshness and speed:

| Mode | Description |
|------|-------------|
| **Strict** | All reads live. No caching. Maximum safety. |
| **Balanced** | Shared state with conservative freshness bounds. Default. |
| **Turbo** | Aggressive caching and fast-path classification within safety bounds. |

All modes preserve the same security guarantees: deterministic enforcement,
verifiable receipts, fail-closed behavior, and zero-trust constraints.
The difference is how much pre-computed work is reused, not whether enforcement occurs.

---

## Benchmark Approach

ATF latency should be evaluated by comparing protected execution against a
standalone bot baseline — the time an unprotected bot takes to independently
complete the same workflow — rather than measuring middleware overhead in isolation.

---

## Roadmap

1. **Measurement** — Establish latency baselines and validate the standalone-bot comparison methodology
2. **Shared infrastructure** — Introduce shared state and caching layers that reduce redundant external calls
3. **Differentiated evaluation** — Classify intents so well-understood patterns resolve faster without weakening enforcement
4. **Productization** — Expose execution mode selection and latency visibility to operators and ecosystem partners

---

## What We Are Not Claiming

- ATF is not latency-positive today. This is a direction, not a shipped capability.
- Not all workloads will benefit equally. Gains depend on concurrency and cache hit rates.
- Security remains non-regressible. No optimization weakens existing guarantees.

---

## Learn More

- [How ATF works](https://trucore.xyz/how-it-works) — public-facing explainer
- [Latency-Positive ATF explainer](https://trucore.xyz/docs/latency-positive-atf) — developer-friendly walkthrough on TruCore.xyz
- [Quickstart](https://trucore.xyz/quickstart)
- [Receipt specification](../spec/receipt.md)
- [Architecture overview](../spec/architecture.md)

For implementation-level strategy, engineering mechanisms, and measurement
framework details, see the
[canonical strategy document](https://github.com/trucore-ai/agent-transaction-firewall/blob/main/docs/strategy/latency_positive_atf.md)
in the ATF implementation repository.
