#!/usr/bin/env bash
# Local markdown link checker for ATF spec repository.
#
# Resolves every relative link target in *.md files and verifies the
# referenced file or directory exists on disk.  External URLs (http(s),
# mailto) and fragment-only links (#…) are skipped.
#
# Usage:  bash scripts/check_links.sh
# Exit 0 = all links valid   Exit 1 = broken links found

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

cd "$REPO_ROOT"

ERRORS=0

for mdfile in $(find . -name '*.md' -not -path './.git/*'); do
  dir="$(dirname "$mdfile")"

  # Extract relative link targets from markdown [text](target)
  # Strips optional fragment (#…) from the target path.
  # Skips URLs (http/s, mailto), fragment-only links, and links with
  # query parameters (GitHub UI navigation, not local files).
  targets=$(grep -oP '\]\(\K(?!https?://|mailto:|#)[^)#\s?]+' "$mdfile" 2>/dev/null || true)

  for target in $targets; do
    resolved="$dir/$target"
    if [ ! -f "$resolved" ] && [ ! -d "$resolved" ]; then
      echo "BROKEN: $mdfile -> $target"
      ERRORS=$((ERRORS + 1))
    fi
  done
done

if [ "$ERRORS" -gt 0 ]; then
  echo ""
  echo "ERROR: $ERRORS broken link(s) detected."
  exit 1
else
  echo "OK: All local markdown links are valid."
  exit 0
fi
