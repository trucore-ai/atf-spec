# Repository Metadata Guidance

This document provides recommended metadata for the `trucore-ai/atf-spec` GitHub repository. These settings are configured through the GitHub UI, not through code.

## GitHub Topics

Recommended topics for the repository (apply via Settings → Topics):

```
agent-transaction-firewall
ai-agents
trading-bots
solana
defi
transaction-security
execution-receipts
receipt-verification
openclaw
jupiter
bot-infrastructure
autonomous-agents
```

## About Description

Suggested repository "About" description:

> Policy-enforced transaction protection for AI trading agents -- receipt format, deterministic verification, threat model, and architecture spec.

## Website Field

Suggested repository "Website" field:

```text
https://trucore.xyz
```

## Maturity Indicator

Current status: **Stable -- Spec v1.0**

### Suggested Badge

```markdown
![Spec Status](https://img.shields.io/badge/spec-v1.0_stable-blue)
```

## Pinned Issue Suggestions

Consider creating the following pinned issues for community engagement:

### 1. Spec Feedback Welcome

Suggested body:

> We welcome feedback on the ATF receipt specification. If you find ambiguities, inconsistencies with observed behavior, or areas that need clarification, please open an issue using the appropriate template.
>
> - Spec clarifications: use the **Spec Clarification** template
> - Documentation errors or mismatches: use the **Bug Report** template
> - Security issues: follow the process in SECURITY.md (do not open public issues)

### 2. Roadmap: Planned Spec Extensions

Suggested body:

> The following extensions are under consideration for future spec versions. These are additive and will not break the existing verification contract:
>
> - Receipt signing (issuer identity and non-repudiation)
> - On-chain attestation anchoring
>
> Discussion welcome. No timeline commitments.

---

## Internal: Discovery keywords (maintainer reference)

<!--
  These are the high-intent phrases this repo should organically rank for.
  They should appear naturally in README / spec docs -- NOT stuffed.
  This list is a maintainer reference for future content updates.

  Primary:
  - AI trading agents
  - autonomous trading bots
  - Solana trading bots
  - transaction policy enforcement
  - execution receipts
  - receipt verification
  - Jupiter swap protection
  - OpenClaw integration
  - non-custodial execution guardrails
  - bot integration middleware
  - crypto algo trading infrastructure
  - DeFi bot security

  Secondary:
  - deterministic verification
  - tamper-evident audit trail
  - agent framework integration
  - Solana bot developer
  - pre-execution policy enforcement
  - machine-readable decision
  - quant developer tooling
-->
