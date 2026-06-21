#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DOC="$ROOT_DIR/docs/codex-for-oss-application-draft.md"
DOC_INDEX="$ROOT_DIR/docs/README.md"

if [[ ! -s "$DOC" ]]; then
  echo "missing Codex application draft" >&2
  exit 1
fi

require_text() {
  local text="$1"
  if ! grep -Fq -- "$text" "$DOC"; then
    echo "Codex application draft missing: $text" >&2
    exit 1
  fi
}

reject_text() {
  local text="$1"
  if grep -Fiq -- "$text" "$DOC"; then
    echo "Codex application draft contains unsupported claim: $text" >&2
    exit 1
  fi
}

require_text "Snapshot date: 2026-06-21"
require_text "Approval is not promised"
require_text "https://github.com/Kkkakania/matlab-scientific-figures"
require_text "Do not submit three repositories"
require_text "v3.8.0"
require_text "6 stars, 4 forks"
require_text "Quality checks"
require_text "Figure quality"
require_text "matlab-figure-ci"
require_text "matlab-plotting-skill"
require_text "python-plotting-skill"
require_text "Form answer: why this repository qualifies"
require_text "Form answer: how API credits or Codex would be used"
require_text "real maintainer work"
require_text "不要写下载量、外部背书、公司认可或通过承诺"
require_text "./scripts/check_static_quality.sh"
require_text "./scripts/check_release_ready.sh"

if ! grep -Fq "(codex-for-oss-application-draft.md)" "$DOC_INDEX"; then
  echo "docs index does not link Codex application draft" >&2
  exit 1
fi

reject_text "guaranteed approval"
reject_text "will be approved"
reject_text "official endorsement"
reject_text "widely adopted"
reject_text "thousands of downloads"
reject_text "申请一定通过"

echo "Codex application draft checks passed."
