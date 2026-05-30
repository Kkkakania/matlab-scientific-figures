#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
GALLERY_DIR="$ROOT_DIR/gallery"

expected=(
  line_plot
  confidence_interval
  scatter_plot
  density_scatter
  grouped_bar
  grouped_error_bar
  positive_negative_area
  heatmap
  correlation_bubble
  bubble_matrix
  box_jitter
  lollipop_ranking
  multi_panel_overview
  surface_3d
)

missing=0
for name in "${expected[@]}"; do
  if [[ ! -s "$GALLERY_DIR/$name.png" ]]; then
    echo "Missing gallery output: gallery/$name.png" >&2
    missing=1
  fi
  if [[ ! -s "$GALLERY_DIR/$name.svg" ]]; then
    echo "Missing gallery output: gallery/$name.svg" >&2
    missing=1
  fi
done

if [[ "$missing" -ne 0 ]]; then
  exit 1
fi

echo "Gallery outputs present."
