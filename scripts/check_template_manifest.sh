#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
MATLAB_BIN="${MATLAB_BIN:-matlab}"
TMP_FILE="$(mktemp)"
SFT_MATLAB_TIMEOUT_SECONDS="${SFT_MATLAB_TIMEOUT_SECONDS:-600}"
trap 'rm -f "$TMP_FILE"' EXIT

source "$ROOT_DIR/scripts/_run_with_timeout.sh"

if [[ "$MATLAB_BIN" == */* ]]; then
  if [[ ! -x "$MATLAB_BIN" ]]; then
    echo "MATLAB executable not found: $MATLAB_BIN" >&2
    exit 127
  fi
elif ! command -v "$MATLAB_BIN" >/dev/null 2>&1; then
  echo "MATLAB executable not found: $MATLAB_BIN" >&2
  exit 127
fi

cd "$ROOT_DIR"
run_with_timeout "$SFT_MATLAB_TIMEOUT_SECONDS" "$MATLAB_BIN" -batch "addpath(genpath('src')); addpath(genpath('examples')); sftWriteTemplateManifest('$TMP_FILE');"
diff -u docs/template-manifest.json "$TMP_FILE"
echo "Template manifest is current."
