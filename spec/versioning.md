# ATF Receipt Spec Versioning Policy

This document defines how the ATF receipt specification is versioned and what compatibility guarantees apply across versions.

## `receipt_version` Semantics

Every ATF receipt includes a `receipt_version` field (e.g., `"1.0"`). This field identifies the schema and canonicalization rules used to produce the receipt.

Versioning follows a **major.minor** scheme:

| Component | Meaning |
|-----------|---------|
| Major     | Breaking changes to schema, required fields, or canonicalization rules. |
| Minor     | Additive or clarifying changes that do not break existing verifiers. |

## Compatibility Rules

### Non-breaking changes (minor version increment)

The following changes are considered **non-breaking** and result in a minor version increment:

- Adding new **optional** fields to the receipt schema.
- Clarifying descriptions or documentation of existing fields (no semantic change).
- Adding new allowed values for existing enum-like fields (e.g., new `decision.status` values), provided existing values retain their meaning.
- Adding guidance or recommendations for verifier behavior that do not invalidate prior receipts.

A verifier written for version `1.x` SHOULD successfully verify any receipt with version `1.y` where `y >= x`, by ignoring unrecognized optional fields.

### Breaking changes (major version increment)

The following changes are considered **breaking** and require a major version increment:

- Removing or renaming required fields.
- Changing the canonicalization algorithm or hash function.
- Changing the semantics of existing required fields.
- Changing the computation of `content_hash` in any way that invalidates prior receipts.

## Deprecation Policy

- Older receipt versions remain **verifiable** indefinitely. A compliant verifier SHOULD support all previously published major versions.
- When a major version is deprecated, this document will note the deprecation date and the recommended migration path.
- Breaking changes will be documented with a clear description of what changed and why.

## Version History

| Spec Version | Status  | Notes |
|-------------|---------|-------|
| `1.0`       | Current | Initial public receipt specification. JCS (RFC 8785) canonicalization, SHA-256 `content_hash`. |

## References

- Receipt schema: [spec/receipt.md](receipt.md)
- Verification procedure: [spec/verification.md](verification.md)
