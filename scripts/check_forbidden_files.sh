#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

forbidden_extensions=(
  "*.7z"
  "*.doc"
  "*.docx"
  "*.fig"
  "*.mat"
  "*.mlx"
  "*.p"
  "*.pdf"
  "*.rar"
  "*.vsd"
  "*.vsdx"
  "*.xls"
  "*.xlsx"
  "*.zip"
)

forbidden_dirs=(
  ".ipynb_checkpoints"
  "__MACOSX"
  "10_inbox"
  "OCR"
  "ocr"
  "raw"
  "source_packs"
  "tmp"
)

forbidden_names=(
  ".DS_Store"
  "Thumbs.db"
  "desktop.ini"
)

found=0

for pattern in "${forbidden_extensions[@]}"; do
  while IFS= read -r file; do
    echo "Forbidden file type found: ${file#$ROOT_DIR/}" >&2
    found=1
  done < <(find "$ROOT_DIR" -path "$ROOT_DIR/.git" -prune -o -type f -iname "$pattern" -print)
done

for dir_name in "${forbidden_dirs[@]}"; do
  while IFS= read -r dir; do
    echo "Forbidden source-material directory found: ${dir#$ROOT_DIR/}" >&2
    found=1
  done < <(find "$ROOT_DIR" -path "$ROOT_DIR/.git" -prune -o -type d -name "$dir_name" -print)
done

for file_name in "${forbidden_names[@]}"; do
  while IFS= read -r file; do
    echo "Forbidden system metadata file found: ${file#$ROOT_DIR/}" >&2
    found=1
  done < <(find "$ROOT_DIR" -path "$ROOT_DIR/.git" -prune -o -type f -name "$file_name" -print)
done

if [[ "$found" -ne 0 ]]; then
  exit 1
fi

echo "Forbidden file check passed."
