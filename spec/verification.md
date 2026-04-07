# ATF Deterministic Verification Procedure

This document specifies how to verify an ATF receipt deterministically, including how `--verify` should behave conceptually.

## Verification goals

A verifier should be able to:

- Confirm the receipt has not been modified (via `content_hash`).
- Confirm the request/context hashes match expected inputs (when those inputs are available).
- Confirm the receipt format is valid for its declared `receipt_version`.

**Verification requires no secrets, API keys, or access to the ATF engine.**

## Inputs to verification

Verification can run in two modes:

### Mode A -- Receipt-only verification

Verifies only the receipt's internal integrity:

- Recompute `content_hash` from receipt content (excluding `content_hash`).
- Compare to `receipt.content_hash`.

This does not require the original request body.

### Mode B -- Receipt + request verification (stronger)

Verifies integrity *and* binding to the evaluated inputs:

- Perform receipt-only verification (Mode A).
- Canonicalize original request body and compute `inputs.request_hash`.
- Optionally canonicalize evaluation context and compute `inputs.context_hash`.
- Compare computed hashes to the values in `receipt.inputs.*`.

## Canonicalization (normative)

This spec uses **JSON Canonicalization Scheme (JCS, RFC 8785)** semantics for:

- Receipt canonicalization (excluding `content_hash`)
- Request body canonicalization (for `inputs.request_hash`)
- Context canonicalization (for `inputs.context_hash`)

For v1, JSON is the expected content type.

## Verification steps (normative)

### Step 1 -- Parse

- Parse receipt as JSON object.
- Fail if invalid JSON.
- Fail if `receipt_version` or `content_hash` is missing.

### Step 2 -- Validate required fields

- Ensure all required top-level fields exist (see `spec/receipt.md`).
- Ensure required nested fields exist.
- Fail on unknown `receipt_version` major version if strict mode is enabled.

### Step 3 -- Recompute `content_hash`

- Create `receipt_copy = deep_copy(receipt)`
- Remove `receipt_copy.content_hash`
- Canonicalize `receipt_copy` via JCS (RFC 8785)
- Compute `sha256(canonical_utf8).hexdigest()` → `computed_content_hash`
- Compare to `receipt.content_hash` (case-sensitive, lowercase hex)
- Fail if mismatch

### Step 4 (optional) -- Verify request binding

If original request body is available:

- Canonicalize request body using JCS.
- Compute `sha256(canonical_request_utf8).hexdigest()` → `computed_request_hash`.
- Compare to `receipt.inputs.request_hash`.
- Fail if mismatch.

If evaluation context is available:

- Canonicalize context JSON using JCS.
- Compute `computed_context_hash`.
- Compare to `receipt.inputs.context_hash`.

### Step 5 -- Output

Verifier should emit:

- `ok` / `fail`
- Failure reason (if applicable)
- Computed hashes (optional but helpful)
- The `request_id` for correlation

## Guarantees and limitations

### Guarantees when verification succeeds

- Receipt content has not been modified since issuance (tamper-evident integrity).
- If Mode B was used, receipt is bound to the provided request body/context via hashes.

### What verification does NOT prove

- Identity of issuer (unless receipts are signed).
- That an on-chain or off-chain execution occurred.
- Correctness of internal policy logic beyond what the receipt reports.

## Recommended verifier behavior

- Provide both a machine-readable output mode (JSON) and human-readable mode.
- Treat any verification failure as fail-closed for automated pipelines.
- Include `request_id` in output for correlation.

## Reference CLI semantics (conceptual)

A `--verify` flag should:

- Accept a receipt JSON (file or stdin).
- Perform receipt-only verification (Mode A) by default.
- Optionally accept `--request <file>` to enable Mode B.
- Exit non-zero on verification failure.

This spec defines the conceptual behavior; implementation details may vary while preserving deterministic outcomes.