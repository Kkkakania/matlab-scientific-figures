#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DOC="$ROOT_DIR/docs/first-use-test.md"
TEMPLATE="$ROOT_DIR/.github/ISSUE_TEMPLATE/first_use_feedback.md"
COLLECTOR="$ROOT_DIR/scripts/collect_first_use_feedback.sh"
CLI_GUIDE="$ROOT_DIR/docs/matlab-cli-guide.md"
QUALITY_GATES="$ROOT_DIR/docs/quality-gates.md"
PROVENANCE_POLICY="$ROOT_DIR/docs/provenance-policy.md"

for file in "$DOC" "$TEMPLATE"; do
  if [[ ! -s "$file" ]]; then
    echo "missing first-use feedback file: ${file#$ROOT_DIR/}" >&2
    exit 1
  fi

  grep -q "Command sequence:" "$file"
  grep -q "Template subset rendered:" "$file"
  grep -q "Output formats:" "$file"
  grep -q "Expected result:" "$file"
  grep -q "Actual result:" "$file"
  grep -q "Private details redacted: yes/no" "$file"
done

grep -q "Do not paste private paths" "$DOC"
grep -q "collect_first_use_feedback.sh" "$DOC"
grep -q "I avoided private data" "$TEMPLATE"
grep -q 'MATLAB_BIN="/c/Program Files/MATLAB/R2025a/bin/matlab.exe"' "$CLI_GUIDE"
grep -q "include the \`.exe\` suffix" "$CLI_GUIDE"
grep -q "\`cmd.exe\` is not a target shell" "$CLI_GUIDE"
grep -q "what the green badges and local checks actually mean" "$QUALITY_GATES"
grep -q "check_forbidden_files_selftest.sh" "$QUALITY_GATES"
grep -q ".mex*" "$QUALITY_GATES"
grep -q "mfigci-report.md" "$QUALITY_GATES"
grep -q "why the examples are synthetic" "$PROVENANCE_POLICY"
bash -n "$COLLECTOR"

TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT
PRIVATE_PATH="/""Users/example/private/project/data.csv"
PRIVATE_GALLERY="/""Users/example/private/gallery"

cat >"$TMP_DIR/figure_report.md" <<'REPORT'
# Figure Report

Selected template: `line_plot`
Recommended alternatives: heatmap, radar_chart
REPORT
printf 'Source file: %s\n' "$PRIVATE_PATH" >>"$TMP_DIR/figure_report.md"
touch "$TMP_DIR/heatmap.png" "$TMP_DIR/heatmap.svg"

feedback="$("$COLLECTOR" \
  --output-dir "$TMP_DIR" \
  --command "SFT_OUTPUT_DIR=$PRIVATE_GALLERY ./scripts/render_all.sh heatmap" \
  --matlab R2025a \
  --os macOS \
  --commit abc1234 \
  --templates "heatmap, radar_chart" \
  --formats "png, svg" \
  --quick-start "passed" \
  --discovery "sftListTemplates worked" \
  --rendering "outputs readable" \
  --helper "render_all.sh worked")"

grep -q "First-use feedback draft" <<<"$feedback"
grep -q "MATLAB: R2025a" <<<"$feedback"
grep -q "Commit: abc1234" <<<"$feedback"
grep -q "Template subset rendered: heatmap, radar_chart" <<<"$feedback"
grep -q "Output formats: png, svg" <<<"$feedback"
grep -q "figure_report.md" <<<"$feedback"
grep -q "heatmap.png" <<<"$feedback"
grep -q "<redacted-path>" <<<"$feedback"

if grep -q "$PRIVATE_GALLERY" <<<"$feedback"; then
  echo "first-use feedback collector leaked a local absolute path" >&2
  echo "$feedback" >&2
  exit 1
fi

echo "First-use feedback documentation checks passed."
