#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TEMPLATE="$ROOT_DIR/.github/ISSUE_TEMPLATE/template_request.md"
QUALITY="$ROOT_DIR/.github/ISSUE_TEMPLATE/quality_check_request.md"
FIRST_USE="$ROOT_DIR/.github/ISSUE_TEMPLATE/first_use_feedback.md"
PR_TEMPLATE="$ROOT_DIR/.github/pull_request_template.md"

for file in "$TEMPLATE" "$QUALITY" "$FIRST_USE" "$PR_TEMPLATE"; do
  if [[ ! -s "$file" ]]; then
    echo "missing GitHub template: ${file#$ROOT_DIR/}" >&2
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
require_text "Review Evidence" "$PR_TEMPLATE"
require_text "Risk And Provenance" "$PR_TEMPLATE"
require_text "Release Notes" "$PR_TEMPLATE"
require_text "deterministic synthetic data" "$PR_TEMPLATE"
require_text "README, template reference, manifest, and gallery docs consistent" "$PR_TEMPLATE"
require_text "No private data, credentials, local absolute paths" "$PR_TEMPLATE"
require_text "Provenance warnings from local checks" "$PR_TEMPLATE"
require_text "does not claim adoption, endorsement, or benefit-program approval" "$PR_TEMPLATE"

echo "GitHub template checks passed."
