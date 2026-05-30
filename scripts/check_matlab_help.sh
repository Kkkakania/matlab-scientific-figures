#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
missing=0

while IFS= read -r file; do
  function_name="$(basename "$file" .m)"
  expected_name="$(printf '%s' "$function_name" | tr '[:lower:]' '[:upper:]')"
  first_line="$(sed -n '1p' "$file")"
  help_line="$(sed -n '2p' "$file")"

  if [[ ! "$first_line" =~ ^function[[:space:]] ]]; then
    echo "MATLAB file does not start with a function declaration: ${file#$ROOT_DIR/}" >&2
    missing=1
    continue
  fi

  if [[ ! "$help_line" =~ ^%${expected_name}[[:space:]] ]]; then
    echo "MATLAB help summary is missing or malformed in ${file#$ROOT_DIR/}" >&2
    echo "Expected line 2 to start with: %${expected_name} " >&2
    missing=1
  fi
done < <(find "$ROOT_DIR/src" -maxdepth 1 -type f -name '*.m' | sort)

if [[ "$missing" -ne 0 ]]; then
  exit 1
fi

echo "MATLAB help text is present."
