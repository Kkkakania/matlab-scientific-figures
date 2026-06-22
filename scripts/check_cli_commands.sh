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

rm -f "$TMP_DIR/harmonic_spectrum.png" "$TMP_DIR/harmonic_spectrum.svg"
SFT_OUTPUT_DIR="$TMP_DIR" MATLAB_BIN="$MATLAB_BIN" ./scripts/render_all.sh harmonic-spectrum
test -s "$TMP_DIR/harmonic_spectrum.png"

rm -f "$TMP_DIR/three_phase_waveform.png" "$TMP_DIR/three_phase_waveform.svg"
SFT_OUTPUT_DIR="$TMP_DIR" MATLAB_BIN="$MATLAB_BIN" ./scripts/render_all.sh three-phase
test -s "$TMP_DIR/three_phase_waveform.png"

rm -f "$TMP_DIR/directional_rose.png" "$TMP_DIR/directional_rose.svg"
SFT_OUTPUT_DIR="$TMP_DIR" MATLAB_BIN="$MATLAB_BIN" ./scripts/render_all.sh directional-rose
test -s "$TMP_DIR/directional_rose.png"

rm -f "$TMP_DIR/data_to_figure.png" "$TMP_DIR/figure_report.md" "$TMP_DIR/figure_report.json"
SFT_OUTPUT_DIR="$TMP_DIR" MATLAB_BIN="$MATLAB_BIN" ./scripts/render_all.sh data-file examples/data/experiment_signal.csv
test -s "$TMP_DIR/data_to_figure.png"
test -s "$TMP_DIR/figure_report.md"
test -s "$TMP_DIR/figure_report.json"

for extended_example in \
  marginal-scatter:marginal_scatter \
  raincloud:raincloud_distribution \
  ribbon:ribbon_comparison \
  vector-field:vector_field \
  polar-bubble:polar_bubble; do
  command_name="${extended_example%%:*}"
  output_name="${extended_example##*:}"
  rm -f "$TMP_DIR/$output_name.png" "$TMP_DIR/$output_name.svg"
  SFT_OUTPUT_DIR="$TMP_DIR" MATLAB_BIN="$MATLAB_BIN" ./scripts/render_all.sh "$command_name"
  test -s "$TMP_DIR/$output_name.png"
done

rm -f "$TMP_DIR/heatmap.png" "$TMP_DIR/heatmap.svg" \
  "$TMP_DIR/radar_chart.png" "$TMP_DIR/radar_chart.svg"
selected_output="$(SFT_OUTPUT_DIR="$TMP_DIR" MATLAB_BIN="$MATLAB_BIN" ./scripts/render_all.sh heatmap radar_chart)"
grep -q "heatmap" <<<"$selected_output"
grep -q "radar_chart" <<<"$selected_output"
test -s "$TMP_DIR/heatmap.png"
test -s "$TMP_DIR/radar_chart.png"
