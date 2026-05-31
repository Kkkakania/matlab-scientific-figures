#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DOC="$ROOT_DIR/docs/first-use-test.md"
TEMPLATE="$ROOT_DIR/.github/ISSUE_TEMPLATE/first_use_feedback.md"

for file in "$DOC" "$TEMPLATE"; do
  if [[ ! -s "$file" ]]; then
    echo "missing first-use feedback file: ${file#$ROOT_DIR/}" >&2
    exit 1
  fi

  grep -q "Command sequence:" "$file"
  grep -q "Template subset rendered:" "$file"
  grep -q "Output formats:" "$file"
  grep -q "Expected result:" "$file"
  grep -q "Actual result:" "$file"
  grep -q "Private details redacted: yes/no" "$file"
done

grep -q "Do not paste private paths" "$DOC"
grep -q "I avoided private data" "$TEMPLATE"

echo "First-use feedback documentation checks passed."
