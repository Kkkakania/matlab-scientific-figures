#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DOC="$ROOT_DIR/docs/compatibility.md"

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

echo "Compatibility documentation covers version-sensitive APIs."
