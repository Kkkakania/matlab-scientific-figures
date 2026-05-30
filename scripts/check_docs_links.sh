#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TMP_LINKS="$(mktemp)"
trap 'rm -f "$TMP_LINKS"' EXIT

found=0

check_target() {
  local source_file="$1"
  local raw_target="$2"
  local target="${raw_target%%#*}"

  if [[ -z "$target" ]]; then
    return
  fi

  case "$target" in
    http://*|https://*|mailto:*) return ;;
  esac

  if [[ "$target" == /* ]]; then
    echo "Absolute local link in ${source_file#$ROOT_DIR/}: $raw_target" >&2
    found=1
    return
  fi

  local source_dir
  source_dir="$(dirname "$source_file")"
  if [[ ! -e "$source_dir/$target" ]]; then
    echo "Broken local link in ${source_file#$ROOT_DIR/}: $raw_target" >&2
    found=1
  fi
}

while IFS= read -r md_file; do
  : > "$TMP_LINKS"

  grep -Eo '\[[^]]+\]\([^)]+\)' "$md_file" \
    | sed -E 's/^.*\]\(([^)]+)\)$/\1/' >> "$TMP_LINKS" || true
  grep -Eo 'src="[^"]+"' "$md_file" \
    | sed -E 's/^src="([^"]+)"$/\1/' >> "$TMP_LINKS" || true

  while IFS= read -r target; do
    check_target "$md_file" "$target"
  done < "$TMP_LINKS"
done < <(find "$ROOT_DIR" -path "$ROOT_DIR/.git" -prune -o -type f -name '*.md' -print)

if [[ "$found" -ne 0 ]]; then
  exit 1
fi

echo "Documentation links are valid."
