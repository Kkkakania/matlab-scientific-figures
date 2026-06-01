#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
EXPECTED_TAG="v2.4.5"

require_text() {
  local file="$1"
  local text="$2"
  if ! grep -q "$text" "$file"; then
    echo "missing matlab-figure-ci dogfood version in ${file#$ROOT_DIR/}: $text" >&2
    exit 1
  fi
}

require_text "$ROOT_DIR/.github/workflows/figure-quality.yml" "matlab-figure-ci.git@$EXPECTED_TAG"
require_text "$ROOT_DIR/README.md" "matlab-figure-ci\` $EXPECTED_TAG"
require_text "$ROOT_DIR/docs/maintainer-dashboard.md" "matlab-figure-ci\` is dogfooded at \`$EXPECTED_TAG\`"
require_text "$ROOT_DIR/docs/quality-gates.md" "matlab-figure-ci\` $EXPECTED_TAG"

echo "matlab-figure-ci dogfood version is aligned: $EXPECTED_TAG"
