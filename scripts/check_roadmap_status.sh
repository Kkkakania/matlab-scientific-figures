#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ROADMAP="$ROOT_DIR/ROADMAP.md"

require_text() {
  local text="$1"
  if ! grep -Fq -- "$text" "$ROADMAP"; then
    echo "ROADMAP.md is missing required status text: $text" >&2
    exit 1
  fi
}

reject_text() {
  local text="$1"
  if grep -Fiq -- "$text" "$ROADMAP"; then
    echo "ROADMAP.md still contains stale planning language: $text" >&2
    exit 1
  fi
}

require_text "## Current State"
require_text "- Current public release: \`v3.8.0\`."
require_text "## Completed Release Tracks"
require_text "### v3.7.0: Bilingual Data-To-Figure Expansion"
require_text "### v3.7.1: Mixed-Script Font Fallback"
require_text "### v3.8.0: Provenance And Intake Hardening"
require_text "## Post-v3.8.0 Hardening On Main"
require_text "No post-\`v3.8.0\` hardening is listed yet."
require_text "Accumulate small fixes on \`main\`"
require_text "## Next Candidates"
require_text "## Versioning Pace"
require_text "Future releases should follow"
require_text "## Non-Goals"
require_text "No artificial usage, stars, comments, or adoption claims."

reject_text "planned additions"
reject_text "later candidates"
reject_text "latest release: \`v0."
reject_text "current public release: \`v0."
reject_text "stable release is \`v0."

echo "ROADMAP status language is current."
