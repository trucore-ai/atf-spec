# Contributing to ATF Spec

Thank you for your interest in improving the ATF public specification.

## Scope

This repository contains **documentation and specification only**. Contributions are welcome for:

- Spec clarifications and corrections
- Documentation improvements (typos, readability, consistency)
- Receipt-example improvements
- Threat-model refinements

Contributions that propose or include **implementation details** — endpoints, headers, enforcement logic, policy semantics, decision taxonomies, or operational parameters — will not be accepted. See [spec/redaction-policy.md](spec/redaction-policy.md) for the full disclosure-minimization policy.

## How to propose changes

1. **Spec clarifications** — open an issue using the **Spec Clarification** template.
2. **Documentation errors** — open an issue using the **Bug Report** template, or submit a pull request directly.
3. **Security issues** — follow the private disclosure process in [SECURITY.md](SECURITY.md). Do **not** open public issues for security vulnerabilities.

## Style guide

- **Tone**: concise, neutral, infrastructure-grade. Avoid marketing language, superlatives, and hype.
- **Tense**: present tense for specification statements; future tense only for planned extensions.
- **Terminology**: use terms defined in the spec consistently; do not introduce synonyms or shorthand that could be confused with internal names.
- **Examples**: receipt examples must use placeholder or redacted values. Extension keys should be generic (`ext_1`, `ext_2`).

## Required local checks

Before opening a pull request, run **both** of the following from the repository root:

```bash
# 1. Verify no forbidden terms have leaked into the repo
bash scripts/check_no_leakage.sh

# 2. Verify all local markdown links resolve
bash scripts/check_links.sh
```

Both scripts must exit with code 0. CI will run the same checks automatically.

## PR checklist

- [ ] Changes are limited to documentation/specification (no implementation detail).
- [ ] `bash scripts/check_no_leakage.sh` passes locally.
- [ ] `bash scripts/check_links.sh` passes locally.
- [ ] No new endpoints, headers, protocol names, or internal identifiers introduced.
- [ ] Wording is consistent with existing spec tone and terminology.
- [ ] If modifying receipt examples: values are placeholders or redacted; no policy semantics implied.

## Maintainer note: public-facing content guidelines

When updating or adding public-facing documentation in this repo, preserve the following positioning:

- **ATF positioning** — frame ATF as a transaction policy enforcement layer, not a generic middleware product.
- **Bot / Solana / agent relevance** — keep examples and language grounded in Solana bot and AI agent use cases.
- **Receipt / verification language** — use "tamper-evident," "deterministic verification," and "execution receipts" consistently.
- **Non-custodial framing** — emphasize that ATF never holds keys or submits transactions on the user's behalf.
- **No internal details** — never reference private repository names, internal service names, or operational parameters.

## Code of conduct

Be respectful, constructive, and concise. This is an infrastructure specification — keep discussions technical and focused.
