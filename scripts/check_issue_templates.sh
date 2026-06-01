#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TEMPLATE="$ROOT_DIR/.github/ISSUE_TEMPLATE/template_request.md"
QUALITY="$ROOT_DIR/.github/ISSUE_TEMPLATE/quality_check_request.md"
FIRST_USE="$ROOT_DIR/.github/ISSUE_TEMPLATE/first_use_feedback.md"

for file in "$TEMPLATE" "$QUALITY" "$FIRST_USE"; do
  if [[ ! -s "$file" ]]; then
    echo "missing issue template: ${file#$ROOT_DIR/}" >&2
    exit 1
  fi
done

require_text() {
  local expected="$1"
  local file="$2"
  if ! grep -q "$expected" "$file"; then
    echo "missing issue-template text in ${file#$ROOT_DIR/}: $expected" >&2
    exit 1
  fi
}

require_text "I am not attaching private data" "$TEMPLATE"
require_text "I am not attaching copied figure code" "$TEMPLATE"
require_text "synthetic" "$TEMPLATE"
require_text "private datasets, copied figures, or third-party source bundles" "$QUALITY"
require_text "Private details redacted: yes/no" "$FIRST_USE"

echo "Issue template checks passed."
