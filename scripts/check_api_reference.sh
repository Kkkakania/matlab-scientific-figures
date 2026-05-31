#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
API_DOC="$ROOT_DIR/docs/api-reference.md"
USER_DATA_DOC="$ROOT_DIR/docs/use-with-your-data.md"

if [[ ! -s "$API_DOC" ]]; then
  echo "Missing API reference: docs/api-reference.md" >&2
  exit 1
fi

missing=0
while IFS= read -r file; do
  function_name="$(basename "$file" .m)"
  if ! grep -Fq "\`$function_name" "$API_DOC"; then
    echo "API reference is missing public function: $function_name" >&2
    missing=1
  fi
done < <(find "$ROOT_DIR/src" -maxdepth 1 -type f -name '*.m' | sort)

if [[ "$missing" -ne 0 ]]; then
  exit 1
fi

if ! grep -Fq "All 30 templates expose small plotting functions" "$USER_DATA_DOC"; then
  echo "Use-with-your-data guide should present reusable plotting functions as the default path." >&2
  exit 1
fi

plot_count="$(find "$ROOT_DIR/src" -maxdepth 1 -type f -name 'sftPlot*.m' | wc -l | tr -d ' ')"
if [[ "$plot_count" -ne 30 ]]; then
  echo "Expected 30 reusable sftPlot*.m functions, found $plot_count" >&2
  exit 1
fi

echo "API reference covers public MATLAB functions."
