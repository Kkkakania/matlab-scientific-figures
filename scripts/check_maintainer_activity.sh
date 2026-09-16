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

require_text "Snapshot date: 2026-09-16"
require_text "not an adoption claim"
require_text "## Own Repositories"
require_text "three electrical domain examples"
require_text "manifest-backed discovery"
require_text "release artifact version validation"
require_text "plotting data-extension validation"
require_text "scientific-diagram-skill"
require_text "checked \`.drawio\` and SVG example"
require_text "manifest validation"
require_text "contribution/security entrypoints"
require_text "python-plotting-skill"
require_text "malformed-manifest handling"
require_text "## Fork And Pull Request Intake"
require_text "five recent merged"
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
require_text "matlab-scientific-figures/pull/72"
require_text "matlab-figure-ci/pull/77"
require_text "matlab-plotting-skill/pull/49"
require_text "scientific-diagram-skill/pull/23"
require_text "python-plotting-skill/pull/38"
require_text "Merged on 2026-09-11"
require_text "## External Pull Requests"
require_text "bokeh/bokeh/pull/15216"
require_text "pyvista/pyvista/pull/8845"
require_text "xarray-contrib/cf-xarray/pull/659"
require_text "xarray-contrib/cf-xarray/pull/661"
require_text "arviz-devs/arviz-plots/pull/542"
require_text "pyqtgraph/pyqtgraph/pull/3507"
require_text "pyqtgraph/pyqtgraph/pull/3538"
require_text "Do not ask for status updates"
require_text "show broad adoption"
require_text "guaranteed program eligibility"

reject_text "widely adopted"
reject_text "thousands of downloads"
reject_text "guaranteed approval"
reject_text "will be approved"
reject_text "fake"

echo "Maintainer activity document is factual and bounded."
