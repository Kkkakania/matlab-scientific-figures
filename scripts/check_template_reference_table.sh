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
  const tags = item.Tags.map((tag) => `\`${tag}\``).join(', ');
  console.log(`| \`${item.Name}\` | \`${item.RendererName}\` | ${item.Task} | ${tags} |`);
}
NODE

sed -nE '/^\| `[^`]+` \| `[^`]+` \| /p' \
  "$ROOT_DIR/docs/template-reference.md" > "$TMP_ACTUAL"

if ! diff -u "$TMP_EXPECTED" "$TMP_ACTUAL"; then
  cat >&2 <<'EOF'
docs/template-reference.md does not match docs/template-manifest.json.
Update the table or regenerate it from the manifest metadata.
EOF
  exit 1
fi

echo "Template reference table matches the manifest."
