#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
MATLAB_BIN="${MATLAB_BIN:-matlab}"

cd "$ROOT_DIR"

list_output="$(MATLAB_BIN="$MATLAB_BIN" ./scripts/render_all.sh list)"
grep -q "line_plot" <<<"$list_output"
grep -q "double_triangle_heatmap" <<<"$list_output"

search_output="$(MATLAB_BIN="$MATLAB_BIN" ./scripts/render_all.sh search matrix)"
grep -q "heatmap" <<<"$search_output"
grep -q "correlation_bubble" <<<"$search_output"
