#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
MATLAB_BIN="${MATLAB_BIN:-matlab}"
TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

cd "$ROOT_DIR"

list_output="$(MATLAB_BIN="$MATLAB_BIN" ./scripts/render_all.sh list)"
grep -q "line_plot" <<<"$list_output"
grep -q "radar_chart" <<<"$list_output"

info_output="$(MATLAB_BIN="$MATLAB_BIN" ./scripts/render_all.sh info heatmap)"
grep -q "renderHeatmap" <<<"$info_output"
grep -q "gallery/heatmap.png" <<<"$info_output"

SFT_OUTPUT_DIR="$TMP_DIR" MATLAB_BIN="$MATLAB_BIN" \
  ./scripts/render_all.sh heatmap radar_chart

test -s "$TMP_DIR/heatmap.png"
test -s "$TMP_DIR/heatmap.svg"
test -s "$TMP_DIR/radar_chart.png"
test -s "$TMP_DIR/radar_chart.svg"

echo "First-use smoke test passed."
