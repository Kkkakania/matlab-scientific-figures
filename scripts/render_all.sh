#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
MATLAB_BIN="${MATLAB_BIN:-matlab}"

if [[ "$MATLAB_BIN" == */* ]]; then
  if [[ ! -x "$MATLAB_BIN" ]]; then
    echo "MATLAB executable not found: $MATLAB_BIN" >&2
    echo "Set MATLAB_BIN to the full MATLAB executable path." >&2
    exit 127
  fi
elif ! command -v "$MATLAB_BIN" >/dev/null 2>&1; then
  echo "MATLAB executable not found: $MATLAB_BIN" >&2
  echo "Try: MATLAB_BIN=/Applications/MATLAB_R2025a.app/bin/matlab ./scripts/render_all.sh" >&2
  exit 127
fi

cd "$ROOT_DIR"

if [[ "$#" -eq 0 ]]; then
  "$MATLAB_BIN" -batch "addpath(genpath('src')); addpath(genpath('examples')); runAllExamples('gallery')"
  exit 0
fi

names=()
for name in "$@"; do
  if [[ ! "$name" =~ ^[a-z0-9_]+$ ]]; then
    echo "Invalid template name: $name" >&2
    echo "Template names may contain lowercase letters, numbers, and underscores." >&2
    exit 2
  fi
  names+=("\"$name\"")
done

name_expr="[$(IFS=,; echo "${names[*]}")]"
"$MATLAB_BIN" -batch "addpath(genpath('src')); addpath(genpath('examples')); sftRenderExamples($name_expr, 'gallery')"
