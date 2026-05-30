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
  console.log(`| \`${item.OutputName}\` | \`${item.RendererName}\` |`);
}
NODE

sed -nE 's/^(\| `[^`]+` \| `[^`]+` \|).*/\1/p' \
  "$ROOT_DIR/examples/README.md" > "$TMP_ACTUAL"

if ! diff -u "$TMP_EXPECTED" "$TMP_ACTUAL"; then
  cat >&2 <<'EOF'
examples/README.md output/function columns do not match the template manifest.
Update the table when template names or renderer functions change.
EOF
  exit 1
fi

echo "Examples README table matches the manifest."
