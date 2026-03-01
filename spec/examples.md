# ATF Receipt Examples

This document provides illustrative receipt examples for reference and testing. These examples demonstrate the receipt structure defined in [spec/receipt.md](receipt.md) and the verification procedure described in [spec/verification.md](verification.md).

> **Note:**
>
> - These examples are **illustrative only** and do not represent actual evaluated requests.
> - Optional fields may be omitted or contain redacted placeholder values.
> - No policy semantics, decision taxonomies, or enforcement logic are implied by any field values.
> - The `content_hash` values shown are **placeholders** for structural demonstration and will not pass live verification.

## Example 1 — Minimal Valid Receipt

This receipt contains only the required fields as defined in [spec/receipt.md](receipt.md).

```json
{
  "receipt_version": "1.0",
  "issued_at": "2026-02-28T20:15:31Z",
  "request_id": "req_8f3a1b2c4d5e6f70",
  "engine": {
    "name": "atf",
    "build": "2026.1.0",
    "api_version": "1.0"
  },
  "decision": {
    "status": "allow",
    "summary": "Request evaluated.",
    "deterministic": true
  },
  "inputs": {
    "content_type": "application/json",
    "request_hash": "a3f2b8c1d4e5f60718293a4b5c6d7e8f9a0b1c2d3e4f5061728394a5b6c7d8e9",
    "context_hash": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  },
  "policy": {
    "policy_hash": "c9d1a2b3e4f5061728394a5b6c7d8e9f0a1b2c3d4e5f60718293a4b5c6d7e8f",
    "policy_version": "1.0"
  },
  "content_hash": "b7e4c1d2a3f5061829304a5b6c7d8e9f0a1b2c3d4e5f607182939a4b5c6d7e80"
}
```

### Notes

- `decision.status` is `"allow"` — one of the three defined values (`allow`, `deny`, `error`).
- `inputs.context_hash` is the SHA-256 of an empty canonical JSON object (`{}`), indicating no additional evaluation context was provided.
- `content_hash` would normally be computed deterministically per [spec/receipt.md](receipt.md). The value shown is a placeholder.

## Example 2 — Receipt with Optional Fields (Redacted)

This receipt includes optional fields with generic or redacted values. The `extensions` object demonstrates extensibility without revealing engine-specific semantics.

```json
{
  "receipt_version": "1.0",
  "issued_at": "2026-02-28T20:17:44Z",
  "request_id": "req_1a2b3c4d5e6f7080",
  "engine": {
    "name": "atf",
    "build": "2026.1.0",
    "api_version": "1.0"
  },
  "decision": {
    "status": "deny",
    "summary": "Denied by policy.",
    "deterministic": true
  },
  "inputs": {
    "content_type": "application/json",
    "request_hash": "d4e5f60718293a4b5c6d7e8f9a0b1c2d3e4f5061728394a5b6c7d8e9f0a1b2c",
    "context_hash": "f061728394a5b6c7d8e9f0a1b2c3d4e5a3f2b8c1d4e5f60718293a4b5c6d7e8"
  },
  "policy": {
    "policy_hash": "718293a4b5c6d7e8f9a0b1c2d3e4f5061728394a5b6c7d8e9f0a1b2c3d4e5f6",
    "policy_version": "1.0"
  },
  "extensions": {
    "ext_1": "redacted",
    "ext_2": "redacted",
    "ext_3": "redacted"
  },
  "trace_id": "trc_9a8b7c6d5e4f3021",
  "warnings": [],
  "content_hash": "9f0a1b2c3d4e5f6071829304a5b6c7d8e9fab1c2d3e4f506182939a4b5c6d7e8"
}
```

### Notes

- `decision.summary` is generic ("Denied by policy.") — no policy semantics are disclosed.
- `extensions` contains placeholder keys with redacted values. In production, extension keys and values are engine-defined and opaque to this spec.
- `trace_id` and `warnings` are optional fields. Their schemas are engine-defined and not specified here.
- All optional fields present in the receipt are included in the `content_hash` computation.
- The `content_hash` value is a placeholder and will not pass verification against this example content.

## Verification Reminder

To verify a receipt, follow the procedure in [spec/verification.md](verification.md):

1. Remove `content_hash` from the receipt.
2. Canonicalize the remaining JSON via JCS (RFC 8785).
3. Compute SHA-256 of the canonical UTF-8 bytes.
4. Compare to the original `content_hash`.

The `content_hash` values in these examples are **placeholders** and will not pass verification. They are included for structural illustration only.
