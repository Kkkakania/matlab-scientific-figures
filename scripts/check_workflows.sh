#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
FIGURE_WORKFLOW="$ROOT_DIR/.github/workflows/figure-quality.yml"
QUALITY_WORKFLOW="$ROOT_DIR/.github/workflows/quality.yml"

if [[ ! -s "$FIGURE_WORKFLOW" ]]; then
  echo "missing figure-quality workflow" >&2
  exit 1
fi

if [[ ! -s "$QUALITY_WORKFLOW" ]]; then
  echo "missing quality workflow" >&2
  exit 1
fi

require_text() {
  local file="$1"
  local text="$2"

  if ! grep -q "$text" "$file"; then
    echo "missing workflow setting in ${file#$ROOT_DIR/}: $text" >&2
    exit 1
  fi
}

reject_text() {
  local file="$1"
  local text="$2"

  if grep -q "$text" "$file"; then
    echo "outdated workflow setting in ${file#$ROOT_DIR/}: $text" >&2
    exit 1
  fi
}

require_text "$FIGURE_WORKFLOW" "FORCE_JAVASCRIPT_ACTIONS_TO_NODE24: true"
require_text "$FIGURE_WORKFLOW" "actions/checkout@v6"
require_text "$FIGURE_WORKFLOW" "actions/setup-python@v6"
require_text "$FIGURE_WORKFLOW" "actions/upload-artifact@v5"
require_text "$FIGURE_WORKFLOW" "mfigci-report.md"
require_text "$FIGURE_WORKFLOW" ".mfigci-results.json"
require_text "$FIGURE_WORKFLOW" "include-hidden-files: true"
reject_text "$FIGURE_WORKFLOW" "actions/checkout@v4"
reject_text "$FIGURE_WORKFLOW" "actions/setup-python@v4"
reject_text "$FIGURE_WORKFLOW" "actions/upload-artifact@v4"

require_text "$QUALITY_WORKFLOW" "actions/checkout@v6"
require_text "$QUALITY_WORKFLOW" "scripts/check_mfigci_dogfood_version.sh"
require_text "$QUALITY_WORKFLOW" "scripts/check_workflows.sh"
require_text "$QUALITY_WORKFLOW" "scripts/check_issue_templates.sh"
require_text "$QUALITY_WORKFLOW" "scripts/check_readme_first_steps.sh"
require_text "$QUALITY_WORKFLOW" "scripts/check_cli_script_static.sh"
require_text "$QUALITY_WORKFLOW" "scripts/check_render_all_args.sh"
require_text "$QUALITY_WORKFLOW" "scripts/check_scan_script_tempfiles.sh"
reject_text "$QUALITY_WORKFLOW" "actions/checkout@v4"

echo "Workflow maintenance checks passed."
