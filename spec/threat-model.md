---
title: ATF Threat Model
summary: Zero-trust threat model for AI agent capital movement — assumptions, attack surfaces, and mitigation design.
layer: public
audience: both
status: spec
product_area: [architecture]
---

# ATF Threat Model (Summary)

ATF is designed for environments where **AI agents can move capital** and **must not be trusted**, even if they appear "aligned."
The default posture is **zero trust**.

This document summarizes the threat model and key assumptions relevant to the public receipt/verification contract. It does not describe internal enforcement mechanisms.

## System context

ATF evaluates transaction intents (or high-risk actions) and produces:

- A deterministic decision (`allow` / `deny` / `error`).
- A deterministic receipt (tamper-evident via `content_hash`).
- Optionally, bounded action constraints (engine-defined, not specified here).

ATF can be used by:

- Interactive users
- Agentic systems
- Automated pipelines
- Downstream auditors/verifiers

## Adversaries

We assume one or more of the following:

- **Compromised agent**: the agent runtime is hijacked; attacker can craft arbitrary requests.
- **Malicious agent**: the agent intentionally attempts unauthorized actions or policy evasion.
- **Compromised integrator**: the application calling ATF is partially compromised.
- **Network attacker**: can observe/modify traffic if transport security is misconfigured.
- **Supply chain attacker**: attempts to inject malicious dependencies or tamper with build artifacts.
- **Insider risk**: misconfiguration or misuse of privileges.

## Assets to protect

- User funds and high-risk authorizations
- Policy integrity (what rules are enforced)
- Decision integrity (what was allowed/denied)
- Audit integrity (receipts/logs must be tamper-evident)
- Availability (resilience to denial-of-service)

## Primary security goals

1. **Fail-closed enforcement**: uncertain or error states must not silently allow high-risk actions.
2. **Bounded authorization**: the engine restricts what an agent can do per evaluated request.
3. **Tamper-evident auditability**: receipts are deterministically verifiable by any party, without secrets.
4. **Replay resistance**: the engine enforces protections against reuse of prior authorizations.
5. **Operational observability**: receipts and logs support incident response and forensics.

## Public contract: receipts

The receipt is the primary public trust artifact. From a threat-model perspective, receipts provide:

- **Stable correlation** via `request_id`.
- **Input binding** via `inputs.request_hash` and `inputs.context_hash`.
- **Tamper-evidence** via deterministic `content_hash`.

Receipts do NOT prove issuer identity (unless separately signed), execution status, or correctness of internal reasoning.

## What this threat model does not cover

- Internal enforcement logic or policy semantics (private).
- Full on-chain verification/attestation mechanics (future roadmap).
- Formal proofs of correctness of the policy engine.
- Complete supply-chain hardening procedures (recommended separately).

## Incident response expectations

Integrators should assume:

- Credentials can be compromised.
- Policies can be misconfigured.
- Agents will behave adversarially under pressure.

Receipts and deterministic verification exist to support:

- Fast containment
- Audit replay
- Root-cause analysis
- External reporting and ecosystem trust