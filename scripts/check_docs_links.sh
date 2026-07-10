#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TMP_LINKS="$(mktemp)"
trap 'rm -f "$TMP_LINKS"' EXIT

found=0

require_link() {
  local source_file="$1"
  local target="$2"

  if ! grep -Fq "($target)" "$ROOT_DIR/$source_file"; then
    echo "Missing required documentation link in $source_file: $target" >&2
    found=1
  fi
}

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

strip_markdown_code() {
  awk '
    /^[[:space:]]*```/ {
      in_fence = !in_fence
      next
    }
    in_fence {
      next
    }
    {
      line = $0
      while (match(line, /`[^`]*`/)) {
        line = substr(line, 1, RSTART - 1) substr(line, RSTART + RLENGTH)
      }
      print line
    }
  ' "$1"
}

while IFS= read -r md_file; do
  : > "$TMP_LINKS"

  strip_markdown_code "$md_file" \
    | grep -Eo '\[[^]]+\]\([^)]+\)' \
    | sed -E 's/^.*\]\(([^)]+)\)$/\1/' >> "$TMP_LINKS" || true
  strip_markdown_code "$md_file" \
    | grep -Eo 'src="[^"]+"' \
    | sed -E 's/^src="([^"]+)"$/\1/' >> "$TMP_LINKS" || true

  while IFS= read -r target; do
    check_target "$md_file" "$target"
  done < "$TMP_LINKS"
done < <(find "$ROOT_DIR" -path "$ROOT_DIR/.git" -prune -o -type f -name '*.md' -print)

require_link "docs/README.md" "../ROADMAP.md"
require_link "README.md" "docs/ecosystem-status.md"

while IFS= read -r doc_file; do
  doc_name="$(basename "$doc_file")"
  if [[ "$doc_name" == "README.md" ]]; then
    continue
  fi
  require_link "docs/README.md" "$doc_name"
done < <(find "$ROOT_DIR/docs" -maxdepth 1 -type f -name '*.md' -print | sort)

if [[ "$found" -ne 0 ]]; then
  exit 1
fi

echo "Documentation links are valid."
