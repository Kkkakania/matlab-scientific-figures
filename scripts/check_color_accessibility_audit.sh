#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TMP_EXPECTED="$(mktemp)"
TMP_ACTUAL="$(mktemp)"
trap 'rm -f "$TMP_EXPECTED" "$TMP_ACTUAL"' EXIT

ROOT_DIR="$ROOT_DIR" node > "$TMP_EXPECTED" <<'NODE'
const fs = require('fs');
const path = require('path');

const root = process.env.ROOT_DIR;
const manifest = JSON.parse(
  fs.readFileSync(path.join(root, 'docs/template-manifest.json'), 'utf8')
);

for (const item of manifest) {
  console.log(item.Name);
}
NODE
sort "$TMP_EXPECTED" -o "$TMP_EXPECTED"

sed -nE 's/^\| `([^`]+)` \| (Low|Medium|High) \|.*$/\1/p' \
  "$ROOT_DIR/docs/color-accessibility.md" > "$TMP_ACTUAL"
sort "$TMP_ACTUAL" -o "$TMP_ACTUAL"

if ! diff -u "$TMP_EXPECTED" "$TMP_ACTUAL"; then
  cat >&2 <<'EOF'
docs/color-accessibility.md does not audit every template in the manifest.
Add or update the Current Gallery Audit table.
EOF
  exit 1
fi

echo "Color accessibility audit covers every template."
