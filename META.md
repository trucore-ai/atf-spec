# Repository Metadata Guidance

This document provides recommended metadata for the `trucore-ai/atf-spec` GitHub repository. These settings are configured through the GitHub UI, not through code.

## GitHub Topics

Recommended topics for the repository:

```
agent-security
transaction-firewall
receipt-verification
deterministic-verification
zero-trust
ai-agent-safety
specification
```

## About Description

Suggested repository "About" description:

> Public specification for the Agent Transaction Firewall (ATF): receipt format, deterministic verification procedure, threat model, and architecture overview.

## Website Field

Suggested repository "Website" field:

```
https://trucore.xyz/docs
```

## Maturity Indicator

Current status: **Stable — Spec v1.0**

This can be reflected in the repository About section or as a badge in the README.

### Suggested Badge (Optional)

If a status badge is desired in the README, use a static shield:

```markdown
![Spec Status](https://img.shields.io/badge/spec-v1.0_stable-blue)
```

This avoids hype language while communicating maturity.

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
