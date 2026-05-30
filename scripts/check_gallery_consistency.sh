#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

runall_list="$TMP_DIR/run_all.txt"
examples_list="$TMP_DIR/examples_readme.txt"
gallery_png_list="$TMP_DIR/gallery_png.txt"
mfigci_png_list="$TMP_DIR/mfigci_png.txt"
check_script_list="$TMP_DIR/check_gallery_outputs.txt"

sed -n "/renderers = {/,/};/p" "$ROOT_DIR/src/runAllExamples.m" \
  | sed -nE "s/^[[:space:]]*'([^']+)'.*/\1/p" > "$runall_list"

sed -nE 's/^\| `([^`]+)` \|.*/\1/p' "$ROOT_DIR/examples/README.md" \
  > "$examples_list"

find "$ROOT_DIR/gallery" -maxdepth 1 -type f -name '*.png' \
  -exec basename {} .png \; | sort > "$gallery_png_list"

sed -nE 's/^[[:space:]]*- "([^"]+)\.png"$/\1/p' "$ROOT_DIR/mfigci.yml" \
  | sort > "$mfigci_png_list"

sed -n '/^expected=(/,/^)/p' "$ROOT_DIR/scripts/check_gallery_outputs.sh" \
  | sed -nE 's/^[[:space:]]*([a-z0-9_]+)$/\1/p' > "$check_script_list"

failure=0

compare_exact() {
  local label="$1"
  local expected="$2"
  local actual="$3"
  if ! diff -u "$expected" "$actual"; then
    echo "Gallery consistency mismatch: $label" >&2
    failure=1
  fi
}

compare_sorted() {
  local label="$1"
  local actual="$2"
  local sorted_expected="$TMP_DIR/run_all_sorted.txt"
  local sorted_actual="$TMP_DIR/${label// /_}_sorted.txt"
  sort "$runall_list" > "$sorted_expected"
  sort "$actual" > "$sorted_actual"
  compare_exact "$label" "$sorted_expected" "$sorted_actual"
}

compare_exact "examples README order" "$runall_list" "$examples_list"
compare_exact "check_gallery_outputs order" "$runall_list" "$check_script_list"
compare_sorted "committed gallery pngs" "$gallery_png_list"
compare_sorted "mfigci png entries" "$mfigci_png_list"

if [[ "$failure" -ne 0 ]]; then
  exit 1
fi

echo "Gallery metadata is consistent."
