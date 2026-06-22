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

require_text "Snapshot date: 2026-06-22"
require_text "not a promise of Codex for Open Source eligibility"
require_text "If the form asks for a single repository"
require_text "Kkkakania/matlab-scientific-figures"
require_text "main application repository"
require_text "Kkkakania/matlab-plotting-skill"
require_text "companion workflow evidence"
require_text "v3.8.0"
require_text "Quality checks"
require_text "Figure quality"
require_text "annotation-free"
require_text "Pull request template"
require_text "issue-triage.yml"
require_text "matlab-scientific-figures#9"
require_text "matlab-scientific-figures#31"
require_text "currently pending on GitHub Project scopes"
require_text "Dependency hygiene"
require_text "dependabot.yml"
require_text "GitHub Actions dependency"
require_text "matlab-figure-ci"
require_text "matlab-plotting-skill"
require_text "scientific-diagram-skill"
require_text "checked \`.drawio\` and \`.svg\` examples"
require_text "python-plotting-skill"
require_text "early cross-language"
require_text "evidence, not as proof of adoption"
require_text "Companion Workflow Snapshot"
require_text "maintenance workflow evidence, not as"
require_text "separate adoption claims"
require_text "877b589"
require_text "27920162827"
require_text "27920162825"
require_text "49711e1"
require_text "27923803978"
require_text "stacked_time_series"
require_text "51-scheme"
require_text "unit-aware"
require_text "data-shape"
require_text "fc9b1f4"
require_text "27925041264"
require_text "README template-count guard"
require_text "15-template"
require_text "lollipop_ranking"
require_text "paired_before_after"
require_text "category_small_multiples"
require_text "0 annotations"
require_text "./scripts/check_static_quality.sh"
require_text "./scripts/check_codex_application_live_snapshot.sh"
require_text "./scripts/check_release_ready.sh"
require_text "hosted GitHub workflows do not prove"
require_text "Do not claim broad adoption"
require_text "Do not cite private local folders"
require_text "practical agent-assisted plotting problem"
require_text "not already widely adopted"

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
reject_text "use the agent-facing skill"
reject_text "skill-first application story"
reject_text "a28131f"
reject_text "27894703366"
reject_text "6fd31e0"
reject_text "27899493672"
reject_text "48e0a71"
reject_text "27906732960"
reject_text "0c76af2"
reject_text "27924618583"
reject_text "dc13ba0"
reject_text "27898635990"
reject_text "4bf723c"
reject_text "27895483759"
reject_text "d880b87"
reject_text "27905568715"
reject_text "13-template"
reject_text "bd061bb"
reject_text "27905926400"
reject_text "1d1d758"
reject_text "27906232479"
reject_text "14-template"
reject_text "a00918e"
reject_text "27894967466"
reject_text "27894967451"

echo "Application evidence packet checks passed."
