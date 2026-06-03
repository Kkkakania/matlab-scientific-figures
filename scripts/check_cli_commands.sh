#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
MATLAB_BIN="${MATLAB_BIN:-matlab}"
TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

cd "$ROOT_DIR"

list_output="$(MATLAB_BIN="$MATLAB_BIN" ./scripts/render_all.sh list)"
grep -q "line_plot" <<<"$list_output"
grep -q "double_triangle_heatmap" <<<"$list_output"

tags_output="$(MATLAB_BIN="$MATLAB_BIN" ./scripts/render_all.sh tags)"
grep -q "matrix" <<<"$tags_output"
grep -q "comparison" <<<"$tags_output"

search_output="$(MATLAB_BIN="$MATLAB_BIN" ./scripts/render_all.sh search matrix)"
grep -q "heatmap" <<<"$search_output"
grep -q "correlation_bubble" <<<"$search_output"

info_output="$(MATLAB_BIN="$MATLAB_BIN" ./scripts/render_all.sh info heatmap)"
grep -q "renderHeatmap" <<<"$info_output"
grep -q "gallery/heatmap.png" <<<"$info_output"

SFT_OUTPUT_DIR="$TMP_DIR" MATLAB_BIN="$MATLAB_BIN" ./scripts/render_all.sh match inset
test -s "$TMP_DIR/zoomed_inset_line.png"

rm -f "$TMP_DIR/zoomed_inset_line.png" "$TMP_DIR/zoomed_inset_line.svg"
SFT_OUTPUT_DIR="$TMP_DIR" MATLAB_BIN="$MATLAB_BIN" ./scripts/render_all.sh tag inset
test -s "$TMP_DIR/zoomed_inset_line.png"

rm -f "$TMP_DIR/csv_experiment_signal.png" "$TMP_DIR/csv_experiment_signal.svg"
SFT_OUTPUT_DIR="$TMP_DIR" MATLAB_BIN="$MATLAB_BIN" ./scripts/render_all.sh csv-example
test -s "$TMP_DIR/csv_experiment_signal.png"

rm -f "$TMP_DIR/pv_power_confidence.png" "$TMP_DIR/pv_power_confidence.svg"
SFT_OUTPUT_DIR="$TMP_DIR" MATLAB_BIN="$MATLAB_BIN" ./scripts/render_all.sh pv-power
test -s "$TMP_DIR/pv_power_confidence.png"

rm -f "$TMP_DIR/heatmap.png" "$TMP_DIR/heatmap.svg" \
  "$TMP_DIR/radar_chart.png" "$TMP_DIR/radar_chart.svg"
selected_output="$(SFT_OUTPUT_DIR="$TMP_DIR" MATLAB_BIN="$MATLAB_BIN" ./scripts/render_all.sh heatmap radar_chart)"
grep -q "heatmap" <<<"$selected_output"
grep -q "radar_chart" <<<"$selected_output"
test -s "$TMP_DIR/heatmap.png"
test -s "$TMP_DIR/radar_chart.png"
