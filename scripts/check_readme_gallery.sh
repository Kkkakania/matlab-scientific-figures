#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

registry_list="$TMP_DIR/registry.txt"
preview_list="$TMP_DIR/readme_preview.txt"
preview_dupes="$TMP_DIR/readme_preview_dupes.txt"

sed -nE 's/^[[:space:]]*makeTemplate\("([^"]+)".*/\1/p' \
  "$ROOT_DIR/src/sftTemplateRegistry.m" > "$registry_list"

registry_count="$(wc -l < "$registry_list" | tr -d ' ')"
readme_count="$(sed -nE 's/^The gallery on `main` contains ([0-9]+) examples\..*/\1/p' "$ROOT_DIR/README.md")"

if [[ -z "$readme_count" ]]; then
  echo "README gallery count sentence is missing or malformed." >&2
  exit 1
fi

if [[ "$readme_count" != "$registry_count" ]]; then
  echo "README gallery count is $readme_count but registry has $registry_count templates." >&2
  exit 1
fi

grep -Eo 'src="gallery/[a-z0-9_]+\.png"' "$ROOT_DIR/README.md" \
  | sed -E 's/^src="gallery\/([^"]+)\.png"$/\1/' > "$preview_list"

preview_count="$(wc -l < "$preview_list" | tr -d ' ')"
if [[ "$preview_count" != "8" ]]; then
  echo "README should show exactly 8 first-screen gallery previews; found $preview_count." >&2
  exit 1
fi

sort "$preview_list" | uniq -d > "$preview_dupes"
if [[ -s "$preview_dupes" ]]; then
  echo "README gallery preview contains duplicate entries:" >&2
  cat "$preview_dupes" >&2
  exit 1
fi

while IFS= read -r name; do
  if ! grep -Fxq "$name" "$registry_list"; then
    echo "README gallery preview is not registered: $name" >&2
    exit 1
  fi
  if [[ ! -s "$ROOT_DIR/gallery/$name.png" ]]; then
    echo "README gallery preview PNG is missing or empty: gallery/$name.png" >&2
    exit 1
  fi
  if [[ ! -s "$ROOT_DIR/gallery/$name.svg" ]]; then
    echo "README gallery preview SVG is missing or empty: gallery/$name.svg" >&2
    exit 1
  fi
done < "$preview_list"

echo "README gallery preview is consistent."
