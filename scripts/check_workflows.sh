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

grep -q "actions/upload-artifact@v5" "$FIGURE_WORKFLOW"
grep -q "FORCE_JAVASCRIPT_ACTIONS_TO_NODE24: true" "$FIGURE_WORKFLOW"
grep -q "scripts/check_workflows.sh" "$QUALITY_WORKFLOW"

echo "Workflow maintenance checks passed."
