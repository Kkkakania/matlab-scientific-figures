#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DOC="$ROOT_DIR/docs/openai-codex-workflow.md"
README="$ROOT_DIR/README.md"
README_ZH="$ROOT_DIR/README.zh-CN.md"
DOC_INDEX="$ROOT_DIR/docs/README.md"
STATIC_GATE="$ROOT_DIR/scripts/check_static_quality.sh"

require_text() {
  local file="$1"
  local text="$2"
  if ! grep -Fq "$text" "$file"; then
    echo "Missing required maintainer workflow text in ${file#$ROOT_DIR/}: $text" >&2
    exit 1
  fi
}

require_text "$DOC" "# Maintainer Workflow"
require_text "$DOC" "## Issue Triage"
require_text "$DOC" "## Pull Request Review"
require_text "$DOC" "## Release Workflow"
require_text "$DOC" "## Security, Privacy, And Provenance"
require_text "$DOC" "## Code Quality Gates"
require_text "$DOC" "Candidate API Credit Uses"
require_text "$DOC" "Do not use external accounts to manufacture activity"
require_text "$DOC" "./scripts/check_static_quality.sh"
require_text "$DOC" "./scripts/check_release_ready.sh"
require_text "$DOC" "matlab-figure-ci"
require_text "$DOC" "fake adoption"
require_text "$README" "docs/openai-codex-workflow.md"
require_text "$README_ZH" "docs/openai-codex-workflow.md"
require_text "$DOC_INDEX" "openai-codex-workflow.md"
require_text "$STATIC_GATE" "check_maintainer_workflow.sh"

echo "Maintainer workflow check passed."
