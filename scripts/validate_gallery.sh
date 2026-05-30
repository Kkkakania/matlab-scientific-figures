#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
MATLAB_BIN="${MATLAB_BIN:-matlab}"
OUT_DIR="${1:-$(mktemp -d)}"
SFT_MATLAB_TIMEOUT_SECONDS="${SFT_MATLAB_TIMEOUT_SECONDS:-600}"

source "$ROOT_DIR/scripts/_run_with_timeout.sh"

if [[ "$MATLAB_BIN" == */* ]]; then
  if [[ ! -x "$MATLAB_BIN" ]]; then
    echo "MATLAB executable not found: $MATLAB_BIN" >&2
    echo "Set MATLAB_BIN to the full MATLAB executable path." >&2
    exit 127
  fi
elif ! command -v "$MATLAB_BIN" >/dev/null 2>&1; then
  echo "MATLAB executable not found: $MATLAB_BIN" >&2
  echo "Try: MATLAB_BIN=/Applications/MATLAB_R2025a.app/bin/matlab ./scripts/validate_gallery.sh" >&2
  exit 127
fi

cd "$ROOT_DIR"
run_with_timeout "$SFT_MATLAB_TIMEOUT_SECONDS" "$MATLAB_BIN" -batch "addpath(genpath('src')); addpath(genpath('examples')); report = sftGalleryReport('$OUT_DIR', [\"png\"]); disp(report); assert(all(report.Passed));"
