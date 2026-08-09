#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

cp "$ROOT_DIR/docs/template-manifest.json" "$TMP_DIR/manifest.json"
cp "$ROOT_DIR/docs/template-reference.md" "$TMP_DIR/reference.md"
printf '%s\n' '| `stale_row` | `renderStale` | stale | `stale` |' >> "$TMP_DIR/reference.md"

if python3 "$ROOT_DIR/scripts/sync_template_reference.py" \
  --manifest "$TMP_DIR/manifest.json" --reference "$TMP_DIR/reference.md" --check; then
  echo "sync check should reject a stale reference table" >&2
  exit 1
fi

python3 "$ROOT_DIR/scripts/sync_template_reference.py" \
  --manifest "$TMP_DIR/manifest.json" --reference "$TMP_DIR/reference.md" --write
python3 "$ROOT_DIR/scripts/sync_template_reference.py" \
  --manifest "$TMP_DIR/manifest.json" --reference "$TMP_DIR/reference.md" --check

cmp "$ROOT_DIR/docs/template-reference.md" "$TMP_DIR/reference.md"
echo "Template reference sync self-test passed."
