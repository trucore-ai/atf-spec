# Frequently Asked Questions

## What does receipt verification prove?

Verification confirms that a receipt has not been modified since issuance (tamper-evident integrity). When the original request body is also provided, verification additionally confirms the receipt is bound to that specific request via cryptographic hashes.

Verification does **not** prove who issued the receipt, whether the underlying action was executed, or that the engine's internal reasoning was correct.

See [spec/verification.md](spec/verification.md) for the full procedure and guarantees.

## Does this repo include the ATF core enforcement engine?

No. This repository contains only the public specification: receipt schema, deterministic verification procedure, threat model, and architecture overview. The core enforcement engine remains private by design.

See [README.md](README.md) for details.

## Can I build a receipt verifier from this spec?

Yes. The verification procedure is fully specified in [spec/verification.md](spec/verification.md) and requires no secrets, API keys, or access to the ATF engine. Any party can independently verify receipt integrity using the documented canonicalization (JCS / RFC 8785) and hash computation steps (SHA-256).

## Are receipts cryptographically signed?

Not in the current spec version. Receipts are tamper-evident via deterministic `content_hash` (SHA-256 of JCS-canonicalized content). Cryptographic signing is a planned optional extension that can be layered without changing the core verification contract.

See [spec/architecture.md](spec/architecture.md) for roadmap notes.

## Is receipt verification proof of on-chain execution?

No. A verified receipt proves only that the receipt content has not been altered since issuance. It does not prove that any on-chain or off-chain action was executed. Execution proofs and on-chain attestation are separate concerns, noted in the architecture roadmap as potential future extensions.

## How does the spec evolve?

The receipt format includes a `receipt_version` field. Changes follow a **major.minor** versioning scheme: minor versions are additive and non-breaking; major versions indicate breaking schema or canonicalization changes. Older versions remain verifiable indefinitely.

See [spec/versioning.md](spec/versioning.md) for the full versioning policy.

## Why are engine internals omitted from this repo?

This specification follows a disclosure-minimization approach. Publishing only the verification contract and receipt format reduces the attack surface, limits adversarial pre-study of enforcement logic, and preserves the integrity of proprietary safety mechanisms. The public spec is sufficient for independent verification and integration without requiring access to internal details.

## Where do I report security issues?

Follow the private disclosure process in [SECURITY.md](SECURITY.md). Email **security@trucore.xyz** with a description of the issue. Do not open public GitHub issues for security vulnerabilities.

## Can I use this spec in my own project?

This repository is licensed under the MIT License. You may reference and use the specification content according to the license terms. See [LICENSE](LICENSE).

## How do I know this spec matches production behavior?

The spec is intended to match TruCore's public documentation and production behavior. If you find a mismatch between this spec and observed behavior, please open an issue. See the Compatibility section in [README.md](README.md).
