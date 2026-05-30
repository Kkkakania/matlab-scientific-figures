#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TARGET="$ROOT_DIR/docs/tag-gallery.md"

generate() {
  ROOT_DIR="$ROOT_DIR" node <<'NODE'
const fs = require('fs');
const path = require('path');

const root = process.env.ROOT_DIR;
const manifest = JSON.parse(
  fs.readFileSync(path.join(root, 'docs/template-manifest.json'), 'utf8')
);

const tagMap = new Map();
for (const item of manifest) {
  for (const tag of item.Tags) {
    if (!tagMap.has(tag)) {
      tagMap.set(tag, []);
    }
    tagMap.get(tag).push(item);
  }
}

const tags = [...tagMap.keys()].sort();

console.log('# Tag Gallery');
console.log('');
console.log('This page is generated from `docs/template-manifest.json`. It groups');
console.log('templates by exact tags accepted by `sftFindTemplatesByTag` and');
console.log('`./scripts/render_all.sh tag`.');
console.log('');
console.log('Regenerate it with:');
console.log('');
console.log('```bash');
console.log('./scripts/check_tag_gallery.sh --write');
console.log('```');
console.log('');

for (const tag of tags) {
  const items = tagMap.get(tag);
  console.log(`## ${tag} (${items.length})`);
  console.log('');
  for (const item of items) {
    console.log(`- \`${item.Name}\` - ${item.Task} ([PNG](../${item.PngFile}), [SVG](../${item.SvgFile}))`);
  }
  console.log('');
}
NODE
}

if [[ "${1:-}" == "--write" ]]; then
  generate > "$TARGET"
  echo "Wrote docs/tag-gallery.md."
  exit 0
fi

TMP_FILE="$(mktemp)"
trap 'rm -f "$TMP_FILE"' EXIT
generate > "$TMP_FILE"

if ! diff -u "$TMP_FILE" "$TARGET"; then
  echo "docs/tag-gallery.md is stale. Run ./scripts/check_tag_gallery.sh --write." >&2
  exit 1
fi

echo "Tag gallery is current."
