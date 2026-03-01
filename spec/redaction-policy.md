# Redaction Policy

This document describes the disclosure-minimization principles applied to the ATF public specification. It is intended for contributors, reviewers, and anyone evaluating the scope of material published in this repository.

## Guiding principle

Publish the **minimum surface area** required for independent receipt verification and integration. Everything else stays private.

## What is intentionally included

| Category | Material | Rationale |
| --- | --- | --- |
| Receipt schema | Field names, types, required/optional status | Integrators need a stable contract to parse and store receipts. |
| Verification procedure | Canonicalization (JCS / RFC 8785), SHA-256, step-by-step algorithm | Third parties must verify receipt integrity without access to the engine. |
| Threat model | Assumptions, trust boundaries, known limitations | Security reviewers need to evaluate the trust model independently. |
| Architecture overview | High-level component roles, extension points | Provides context without exposing internals. |
| Versioning policy | Major/minor scheme, deprecation rules, version history | Consumers need to plan for spec evolution. |
| Receipt examples | Illustrative JSON with redacted or placeholder values | Demonstrates structure; does not encode real policy decisions. |

## What is intentionally omitted

The following categories are **never** published in this repository:

- **Enforcement logic** — internal decision procedures, rule sets, or evaluation algorithms.
- **Policy semantics** — how policies are authored, composed, or applied.
- **Decision taxonomies** — enumerated reason values, status sub-codes, or category labels.
- **Endpoint and protocol details** — paths, headers, request/response shapes, transport specifics.
- **Adapter or integration internals** — chain-specific adapters, service names, third-party identifiers.
- **Operational parameters** — thresholds, timing values, capacity figures, or tuning constants.
- **Infrastructure identifiers** — service mesh names, queue topics, internal hostnames.

## Why this matters

Limiting public detail:

1. **Reduces attack surface** — adversaries cannot pre-study enforcement mechanisms.
2. **Preserves proprietary value** — core safety logic remains a competitive advantage.
3. **Prevents coupling** — external integrators depend only on the stable receipt contract, insulating them from internal refactors.
4. **Simplifies maintenance** — fewer published details means fewer things that can become stale or inconsistent.

## Contributor checklist — before opening or merging a PR

Use this checklist for every change to any file in this repo:

- [ ] Does this change introduce any term from the forbidden-terms list? Run `bash scripts/check_no_leakage.sh` to verify.
- [ ] Does this change describe *how* the engine makes decisions (rather than *what* the receipt contains)?
- [ ] Does this change name a specific service, endpoint, header, or protocol detail?
- [ ] Does this change include numeric thresholds, timing values, or capacity figures?
- [ ] Does this change reference internal project names, adapters, or third-party service identifiers?

If the answer to **any** question above is *yes*, the change should be reworked or rejected.

## Handling edge cases

- **Ambiguous terms**: some words appear in both public specification and internal contexts. Prefer specificity (e.g., "receipt field" instead of a generic term that could also name an internal component).
- **Examples**: receipt examples must use placeholder or redacted values for any field whose real content would reveal enforcement semantics. Extension keys should be generic (e.g., `ext_1`, `ext_2`).
- **Roadmap items**: it is acceptable to mention *that* an extension is planned (e.g., "receipt signing") without describing *how* it will be implemented.
