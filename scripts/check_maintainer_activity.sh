#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DOC="$ROOT_DIR/docs/maintainer-activity.md"

if [[ ! -s "$DOC" ]]; then
  echo "missing maintainer activity document" >&2
  exit 1
fi

require_text() {
  local text="$1"
  if ! grep -Fq -- "$text" "$DOC"; then
    echo "maintainer activity document missing: $text" >&2
    exit 1
  fi
}

reject_text() {
  local text="$1"
  if grep -Fiq -- "$text" "$DOC"; then
    echo "maintainer activity document contains unsupported claim: $text" >&2
    exit 1
  fi
}

require_text "Snapshot date: 2026-07-09"
require_text "not an adoption claim"
require_text "## Own Repositories"
require_text "three electrical domain examples"
require_text "render_all.sh help examples"
require_text "init verification guidance"
require_text "stable first-use scheme list"
require_text "scientific-diagram-skill"
require_text "checked \`.drawio\` and SVG example"
require_text "contribution/security entrypoints"
require_text "python-plotting-skill"
require_text "v0.2 template request issue"
require_text "## Fork And Pull Request Intake"
require_text "four merged maintenance"
require_text "Ahead commits to review"
require_text "./scripts/check_fork_intake_status.sh"
require_text "Visible forks checked"
require_text "matlab-scientific-figures"
require_text "matlab-figure-ci"
require_text "matlab-plotting-skill"
require_text "scientific-diagram-skill"
require_text "python-plotting-skill"
require_text '`python-plotting-skill` | 0 | 0'
require_text '`scientific-diagram-skill` | 0 | 0'
require_text "Fantastic-wil2"
require_text "Recently merged own-repository pull request snapshot"
require_text "matlab-figure-ci/pull/44"
require_text "matlab-plotting-skill/pull/21"
require_text "scientific-diagram-skill/pull/4"
require_text "python-plotting-skill/pull/12"
require_text "Merged on 2026-07-09"
require_text "## External Pull Requests"
require_text "matlab2tikz/matlab2tikz/pull/1158"
require_text "fieldtrip/fieldtrip/pull/2591"
require_text "fieldtrip/website/pull/927"
require_text "chebfun/chebfun/pull/2495"
require_text "scottclowe/matlab-schemer/pull/47"
require_text "PRML/PRMLT/pull/54"
require_text "holoviz/panel/pull/8652"
require_text "owenpkent/coverage-compass/pull/11"
require_text "tim-fuchs/hiit-workout-planner/pull/12"
require_text "Do not ask for status updates"
require_text "show broad adoption"
require_text "guaranteed program eligibility"

reject_text "widely adopted"
reject_text "thousands of downloads"
reject_text "guaranteed approval"
reject_text "will be approved"
reject_text "fake"

echo "Maintainer activity document is factual and bounded."
