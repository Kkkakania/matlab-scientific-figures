#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DOC="$ROOT_DIR/docs/ecosystem-status.md"
README="$ROOT_DIR/README.md"

require_text() {
  local file="$1"
  local text="$2"

  if ! grep -Fq "$text" "$file"; then
    echo "Missing ecosystem handoff text in ${file#$ROOT_DIR/}: $text" >&2
    exit 1
  fi
}

require_text "$DOC" "## Handoff Contract"
require_text "$DOC" "Producer artifact"
require_text "$DOC" "Next consumer"
require_text "$DOC" "gallery/*.png and gallery/*.svg"
require_text "$DOC" "mfigci-report.md and .mfigci-results.json"
require_text "$DOC" "render_report.md and render_report.json"
require_text "$DOC" "scientific-diagram-skill"
require_text "$DOC" ".drawio"
require_text "$DOC" "scientific-diagram-skill#1"
require_text "$DOC" "python-plotting-skill"
require_text "$DOC" "docs/gallery/*.png and docs/gallery/*.svg"
require_text "$DOC" "python-plotting-skill#1"
require_text "$DOC" "matlab-plotting-skill now runs mfigci check"
require_text "$DOC" "before a render result becomes first-use feedback"
require_text "$DOC" "Do not move private datasets"
require_text "$DOC" "handoff means artifacts and commands"
require_text "$README" "handoff contract"
require_text "$README" "python-plotting-skill"
require_text "$README" "scientific-diagram-skill"

echo "Ecosystem handoff documentation is present."
