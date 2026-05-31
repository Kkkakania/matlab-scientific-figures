#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
README="$ROOT_DIR/README.md"

require_text() {
  local text="$1"
  if ! grep -Fq -- "$text" "$README"; then
    echo "README.md is missing first-steps text: $text" >&2
    exit 1
  fi
}

require_text "## First 5 Minutes"
require_text "1. Inspect the available templates without rendering anything."
require_text "./scripts/render_all.sh list"
require_text "./scripts/render_all.sh info heatmap"
require_text "2. Render one known template into a scratch directory."
require_text "SFT_OUTPUT_DIR=/tmp/sft-first-render"
require_text "3. Try the bundled CSV example before wiring in your own data."
require_text "./scripts/render_all.sh csv-example"
require_text "Move to your own data only after those three checks pass."

echo "README first-steps checks passed."
