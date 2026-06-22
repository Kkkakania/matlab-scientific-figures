#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DOC="$ROOT_DIR/docs/codex-for-oss-evidence.md"
DOC_INDEX="$ROOT_DIR/docs/README.md"
STATIC_GATE="$ROOT_DIR/scripts/check_static_quality.sh"

if [[ ! -s "$DOC" ]]; then
  echo "missing Codex for OSS evidence note" >&2
  exit 1
fi

require_text() {
  local text="$1"
  if ! grep -Fq -- "$text" "$DOC"; then
    echo "Codex evidence note missing: $text" >&2
    exit 1
  fi
}

reject_text() {
  local text="$1"
  if grep -Fiq -- "$text" "$DOC"; then
    echo "Codex evidence note contains unsupported or stale claim: $text" >&2
    exit 1
  fi
}

require_text "Snapshot date: 2026-06-22"
require_text "not a promise of eligibility"
require_text "Kkkakania/matlab-scientific-figures"
require_text "v3.8.0"
require_text "6 GitHub stars, 4 forks"
require_text "Companion snapshot checked on 2026-06-22"
require_text "checked baselines, not latest-commit claims"
require_text "matlab-figure-ci"
require_text "877b589"
require_text "27920162827"
require_text "27920162825"
require_text "release-preflight JSON"
require_text "matlab-plotting-skill"
require_text "9fd2478"
require_text "27928892308"
require_text "51-scheme"
require_text "stacked_time_series"
require_text "unit-aware"
require_text "data-shape"
require_text "scientific diagram"
require_text "Diagram example validation"
require_text "python-plotting-skill"
require_text "fc9b1f4"
require_text "27925041264"
require_text "README template-count guard"
require_text "15-template"
require_text "category_small_multiples"
require_text "Do not present these numbers as broad adoption"
require_text "How Codex/API Credits Would Be Used"
require_text "PR review"
require_text "issue triage"
require_text "release-note drafting"
require_text "CI failure analysis"
require_text 'compact summaries of `matlab-figure-ci` reports'

if ! grep -Fq "(codex-for-oss-evidence.md)" "$DOC_INDEX"; then
  echo "docs index does not link Codex for OSS evidence note" >&2
  exit 1
fi

if ! grep -Fq "check_codex_evidence_note.sh" "$STATIC_GATE"; then
  echo "static quality gate does not run Codex evidence note check" >&2
  exit 1
fi

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
reject_text "49711e1"
reject_text "27923803978"
reject_text "f09dcca"
reject_text "27926156956"
reject_text "guaranteed approval"
reject_text "will be approved"
reject_text "official endorsement"
reject_text "widely adopted"
reject_text "thousands of downloads"
reject_text "申请一定通过"

echo "Codex evidence note checks passed."
