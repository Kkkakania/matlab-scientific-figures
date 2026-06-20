#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
FIGURE_WORKFLOW="$ROOT_DIR/.github/workflows/figure-quality.yml"
QUALITY_WORKFLOW="$ROOT_DIR/.github/workflows/quality.yml"
TRIAGE_WORKFLOW="$ROOT_DIR/.github/workflows/issue-triage.yml"
DEPENDABOT_CONFIG="$ROOT_DIR/.github/dependabot.yml"

if [[ ! -s "$FIGURE_WORKFLOW" ]]; then
  echo "missing figure-quality workflow" >&2
  exit 1
fi

if [[ ! -s "$QUALITY_WORKFLOW" ]]; then
  echo "missing quality workflow" >&2
  exit 1
fi

if [[ ! -s "$TRIAGE_WORKFLOW" ]]; then
  echo "missing issue triage workflow" >&2
  exit 1
fi

if [[ ! -s "$DEPENDABOT_CONFIG" ]]; then
  echo "missing dependabot configuration" >&2
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

require_text "$TRIAGE_WORKFLOW" "issues:"
require_text "$TRIAGE_WORKFLOW" "types: \[opened\]"
require_text "$TRIAGE_WORKFLOW" "issues: write"
require_text "$TRIAGE_WORKFLOW" "matlab-figure-ecosystem-triage"
require_text "$TRIAGE_WORKFLOW" "gh issue comment"
require_text "$TRIAGE_WORKFLOW" "Kkkakania/matlab-scientific-figures#31"
require_text "$TRIAGE_WORKFLOW" "Awaiting feedback"
reject_text "$TRIAGE_WORKFLOW" "project:"
reject_text "$TRIAGE_WORKFLOW" "read:project"

require_text "$DEPENDABOT_CONFIG" "version: 2"
require_text "$DEPENDABOT_CONFIG" "package-ecosystem: github-actions"
require_text "$DEPENDABOT_CONFIG" 'directory: "/"'
require_text "$DEPENDABOT_CONFIG" "interval: weekly"
require_text "$DEPENDABOT_CONFIG" "open-pull-requests-limit: 5"
require_text "$DEPENDABOT_CONFIG" "prefix: ci"

echo "Workflow maintenance checks passed."
