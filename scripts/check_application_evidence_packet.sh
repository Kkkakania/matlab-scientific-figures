#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DOC="$ROOT_DIR/docs/application-evidence-packet.md"
DOC_INDEX="$ROOT_DIR/docs/README.md"
STATIC_GATE="$ROOT_DIR/scripts/check_static_quality.sh"

if [[ ! -s "$DOC" ]]; then
  echo "missing application evidence packet" >&2
  exit 1
fi

require_text() {
  local text="$1"
  if ! grep -Fq -- "$text" "$DOC"; then
    echo "application evidence packet missing: $text" >&2
    exit 1
  fi
}

reject_text() {
  local text="$1"
  if grep -Fiq -- "$text" "$DOC"; then
    echo "application evidence packet contains unsupported claim: $text" >&2
    exit 1
  fi
}

require_text "Snapshot date: 2026-06-20"
require_text "not a promise of Codex for Open Source eligibility"
require_text "Kkkakania/matlab-scientific-figures"
require_text "v3.8.0"
require_text "Quality checks"
require_text "Figure quality"
require_text "Pull request template"
require_text "issue-triage.yml"
require_text "matlab-scientific-figures#9"
require_text "matlab-scientific-figures#31"
require_text "currently pending on GitHub Project scopes"
require_text "matlab-figure-ci"
require_text "matlab-plotting-skill"
require_text "./scripts/check_static_quality.sh"
require_text "./scripts/check_release_ready.sh"
require_text "hosted GitHub workflows do not prove"
require_text "Do not claim broad adoption"
require_text "Do not cite private local folders"
require_text "not that it is already widely adopted"

if ! grep -Fq "(application-evidence-packet.md)" "$DOC_INDEX"; then
  echo "docs index does not link application evidence packet" >&2
  exit 1
fi

if ! grep -Fq "check_application_evidence_packet.sh" "$STATIC_GATE"; then
  echo "static quality gate does not run application evidence packet check" >&2
  exit 1
fi

reject_text "guaranteed approval"
reject_text "will be approved"
reject_text "widely adopted project"
reject_text "thousands of downloads"
reject_text "official endorsement"

echo "Application evidence packet checks passed."
