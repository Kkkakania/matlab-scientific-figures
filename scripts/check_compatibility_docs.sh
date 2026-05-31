#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DOC="$ROOT_DIR/docs/compatibility.md"
MATCHES_FILE="$(mktemp)"
trap 'rm -f "$MATCHES_FILE"' EXIT

required_terms=(
  'R2020b'
  'R2025a'
  'exportgraphics'
  'tiledlayout'
  'jsonencode'
  'datetime'
  'string arrays'
  'toolbox'
)

missing=0
for term in "${required_terms[@]}"; do
  if ! grep -Fq "$term" "$DOC"; then
    echo "docs/compatibility.md should mention: $term" >&2
    missing=1
  fi
done

if [[ "$missing" -ne 0 ]]; then
  exit 1
fi

version_gated_patterns=(
  'clim('
  'fontsize('
  'fontname('
)

for pattern in "${version_gated_patterns[@]}"; do
  if grep -RFn --include='*.m' "$pattern" "$ROOT_DIR/src" "$ROOT_DIR/examples" > "$MATCHES_FILE"; then
    echo "Source uses version-sensitive MATLAB API '$pattern' while docs state an R2020b floor:" >&2
    cat "$MATCHES_FILE" >&2
    echo "Use an older compatible API or update docs/compatibility.md and this check." >&2
    exit 1
  fi
done

echo "Compatibility documentation covers version-sensitive APIs."
