# ATF Spec (Public)

![Spec Status](https://img.shields.io/badge/spec-v1.0_stable-blue)

This repository contains the **public specification and interface contract** for the **Agent Transaction Firewall (ATF)**.

- ✅ Public: receipt format, deterministic verification procedure, threat model, and architecture overview
- ❌ Not included: proprietary ATF enforcement engine implementation (core remains private)

ATF is designed for **zero-trust** environments where **agents may be adversarial or compromised**. The core product produces **deterministic receipts** that can be independently verified.

## What this repo is (and is not)

### This repo is:
- A stable, citable specification for:
  - Receipt schema and field definitions
  - Deterministic verification procedure and guarantees
  - Threat model and assumptions
  - Architecture overview and roadmap interface contract
- A reference point for builders integrating ATF via CLI and API

### This repo is not:
- The ATF core enforcement engine source code
- A "full open-source release" of ATF

> **Core enforcement remains private** to reduce supply-chain risk and to preserve proprietary safety logic.
> This spec repo exists so that *integrators can rely on a stable contract* and *auditors can verify receipts deterministically*.

## Disclosure minimization

This specification intentionally omits internal enforcement logic, policy semantics, decision taxonomies, and operational details. Publishing only the receipt format and verification procedure limits the attack surface available to adversaries, prevents pre-study of enforcement mechanisms, and preserves the integrity of proprietary safety controls. The public contract is sufficient for independent receipt verification and integration; internal details are not required for those purposes.

For the full policy on what is included and omitted, see the [redaction policy](spec/redaction-policy.md).

## Documents

- Receipt format: [`spec/receipt.md`](spec/receipt.md)
- Verification procedure: [`spec/verification.md`](spec/verification.md)
- Threat model: [`spec/threat-model.md`](spec/threat-model.md)
- Architecture overview: [`spec/architecture.md`](spec/architecture.md)
- Versioning policy: [`spec/versioning.md`](spec/versioning.md)
- Receipt examples: [`spec/examples.md`](spec/examples.md)
- Redaction policy: [`spec/redaction-policy.md`](spec/redaction-policy.md)
- FAQ: [`FAQ.md`](FAQ.md)

## Verification scope

### What verification proves

- The receipt content has not been modified since issuance (tamper-evident integrity).
- When the original request body is provided, the receipt is bound to that specific request via cryptographic hashes (input binding).

### What verification does not prove

- **Issuer identity** — receipts are not signed in the current spec version (signing is a planned extension).
- **Execution status** — a verified receipt does not confirm that any on-chain or off-chain action was executed.
- **Policy correctness** — verification confirms integrity, not that internal enforcement logic is bug-free.

See [`spec/verification.md`](spec/verification.md) for the full procedure.

## Compatibility

This spec is intended to match TruCore's public documentation and production behavior:
- Deterministic verification (`--verify`)
- Receipt `request_id` passthrough semantics
- Deterministic `content_hash` computed from canonicalized receipt content

If you find a mismatch between this spec and observed behavior, please open an issue.

## Contributing

See [`CONTRIBUTING.md`](CONTRIBUTING.md) for scope, guidelines, and required local checks.

## Security

Please follow the disclosure process in [`SECURITY.md`](SECURITY.md).
For security reports: **security@trucore.xyz**

## License

This repository is licensed under the MIT License (docs/spec content).
See [`LICENSE`](LICENSE).

## Spec stability

The receipt format includes a `receipt_version` field following a **major.minor** scheme:

- **Minor** increments are additive and non-breaking (new optional fields, clarifications).
- **Major** increments indicate breaking changes (schema, canonicalization, or hash function changes).
- Older receipt versions remain verifiable indefinitely.

Current version: **v1.0** (stable).

See [`spec/versioning.md`](spec/versioning.md) for the full versioning policy, compatibility rules, and version history.
