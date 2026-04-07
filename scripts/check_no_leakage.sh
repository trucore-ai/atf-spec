#!/usr/bin/env bash
# Forbidden-term scanner for ATF spec repository.
#
# Checks all tracked text files for terms that would indicate internal
# implementation details have leaked into the public specification.
#
# Usage:  bash scripts/check_no_leakage.sh
# Exit 0 = clean   Exit 1 = forbidden terms found

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# ---------------------------------------------------------------------------
# Forbidden patterns (case-insensitive, extended regex)
# Word boundaries (\b) are used where the term could appear as a substring
# of legitimate words.  Patterns without a trailing \b intentionally match
# plural / derived forms (e.g. "guardrails").
# ---------------------------------------------------------------------------
PATTERNS=(
  '\bjupiter\b'
  '\bsolend\b'
  '\braydium\b'
  '\bswap\b'
  '\bslippage\b'
  'x-request-id'
  '/v1/'
  '/api/'
  '\breason_code\b'
  '\bguardrail'
  '\brouter\b'
  '\bvault\b'
  '\bnonce\b'
  '\bttl\b'
  'domain separation'
  '\ballowlist\b'
  'rate limit'
  '\bbps\b'
)

# ---------------------------------------------------------------------------
# Per-pattern file exclusions (associative)
# Key = pattern string, Value = extra --exclude arg.
#
# Justification for each exclusion:
#   reason_code -> receipt.md: The receipt schema defines `decision.reason_code`
#     as a field name (v1.0 contract). The forbidden-term rule targets leaked
#     reason-code VALUE LISTS, not the field definition itself.
# ---------------------------------------------------------------------------
declare -A PATTERN_EXCLUDES=(
  ['\breason_code\b']='receipt.md'
)

# ---------------------------------------------------------------------------
# Global file exclusions
# README.md and META.md serve as public discovery/positioning surfaces and
# intentionally reference product-adjacent terms (e.g. Jupiter, swap) that
# the spec documents must not contain.  Excluding them here keeps the check
# focused on spec content while allowing legitimate discovery language.
# ---------------------------------------------------------------------------
GLOBAL_EXCLUDES=( 'README.md' 'META.md' )

FOUND=0

for pattern in "${PATTERNS[@]}"; do
  extra_exclude="${PATTERN_EXCLUDES[$pattern]:-}"
  extra_flag=""
  if [ -n "$extra_exclude" ]; then
    extra_flag="--exclude=$extra_exclude"
  fi

  global_flags=""
  for gx in "${GLOBAL_EXCLUDES[@]}"; do
    global_flags="$global_flags --exclude=$gx"
  done

  matches=$(grep -r -i -n -E "$pattern" "$REPO_ROOT" \
    --include='*.md' --include='*.yml' --include='*.yaml' \
    --include='*.json' --include='*.sh' --include='*.txt' \
    --exclude='check_no_leakage.sh' \
    $extra_flag \
    $global_flags \
    --exclude-dir='.git' \
    --exclude-dir='node_modules' 2>/dev/null || true)
  if [ -n "$matches" ]; then
    echo "MATCH [$pattern]:"
    echo "$matches"
    echo ""
    FOUND=1
  fi
done

if [ "$FOUND" -eq 1 ]; then
  echo "========================================="
  echo "FAIL: Forbidden terms detected (see above)."
  echo "========================================="
  exit 1
else
  echo "OK: No forbidden terms found."
  exit 0
fi
