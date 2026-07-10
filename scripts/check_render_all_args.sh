#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SCRIPT="$ROOT_DIR/scripts/render_all.sh"
TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

expect_failure() {
  local expected="$1"
  shift
  local out_file="$TMP_DIR/out.txt"
  local err_file="$TMP_DIR/err.txt"
  local status

  set +e
  "$@" >"$out_file" 2>"$err_file"
  status=$?
  set -e

  if [[ "$status" -ne 2 ]]; then
    echo "expected exit 2, got $status" >&2
    cat "$err_file" >&2
    exit 1
  fi

  if ! grep -q "$expected" "$err_file"; then
    echo "expected error containing: $expected" >&2
    cat "$err_file" >&2
    exit 1
  fi
}

expect_failure "Invalid SFT_FORMATS entry: jpg" \
  env SFT_FORMATS=png,jpg MATLAB_BIN=/no/such/matlab "$SCRIPT" list

expect_failure "Invalid SFT_FORMATS entry: p ng" \
  env "SFT_FORMATS=p ng" MATLAB_BIN=/no/such/matlab "$SCRIPT" list

expect_failure "SFT_FORMATS must include at least one" \
  env SFT_FORMATS=, MATLAB_BIN=/no/such/matlab "$SCRIPT" list

expect_failure "SFT_OUTPUT_DIR may not contain single quotes" \
  env "SFT_OUTPUT_DIR=bad'path" MATLAB_BIN=/no/such/matlab "$SCRIPT" list

expect_failure "SFT_OUTPUT_DIR may not contain control characters" \
  env SFT_OUTPUT_DIR=$'bad\npath' MATLAB_BIN=/no/such/matlab "$SCRIPT" list

expect_failure "SFT_OUTPUT_DIR must not be empty" \
  env SFT_OUTPUT_DIR= MATLAB_BIN=/no/such/matlab "$SCRIPT" list

expect_failure "Usage: ./scripts/render_all.sh search <keyword>" \
  env MATLAB_BIN=/no/such/matlab "$SCRIPT" search

expect_failure "Usage: ./scripts/render_all.sh info <template>" \
  env MATLAB_BIN=/no/such/matlab "$SCRIPT" info heatmap radar_chart

expect_failure "Invalid template name: Heatmap" \
  env MATLAB_BIN=/no/such/matlab "$SCRIPT" Heatmap

expect_failure "Data file path must end with .csv, .xls, or .xlsx" \
  env MATLAB_BIN=/no/such/matlab "$SCRIPT" data-file private.mat

help_output="$(env SFT_FORMATS=bad MATLAB_BIN=/no/such/matlab "$SCRIPT" help)"
grep -q "Usage: ./scripts/render_all.sh" <<<"$help_output"
grep -q "SFT_FORMATS" <<<"$help_output"
grep -q "Examples:" <<<"$help_output"
grep -q "./scripts/render_all.sh list" <<<"$help_output"
grep -q "SFT_FORMATS=png,svg,pdf" <<<"$help_output"

FAKE_MATLAB="$TMP_DIR/fake_matlab"
CAPTURED_ARGS="$TMP_DIR/matlab_args.txt"
cat >"$FAKE_MATLAB" <<'SH'
#!/usr/bin/env bash
printf '%s\n' "$*" >"$CAPTURED_ARGS"
SH
chmod +x "$FAKE_MATLAB"

env CAPTURED_ARGS="$CAPTURED_ARGS" SFT_FORMATS=pdf MATLAB_BIN="$FAKE_MATLAB" "$SCRIPT" heatmap >/dev/null
grep -q 'sftRenderExamples(\["heatmap"\]' "$CAPTURED_ARGS"
grep -q '\["pdf"\]' "$CAPTURED_ARGS"

env CAPTURED_ARGS="$CAPTURED_ARGS" MATLAB_BIN="$FAKE_MATLAB" "$SCRIPT" heatmap >/dev/null
grep -q '\["png","svg"\]' "$CAPTURED_ARGS"

env CAPTURED_ARGS="$CAPTURED_ARGS" SFT_FORMATS=png,png,svg MATLAB_BIN="$FAKE_MATLAB" "$SCRIPT" heatmap >/dev/null
grep -q '\["png","svg"\]' "$CAPTURED_ARGS"

echo "render_all argument checks passed."
