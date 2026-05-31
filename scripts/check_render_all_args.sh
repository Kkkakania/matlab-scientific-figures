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

expect_failure "SFT_FORMATS must include at least one" \
  env SFT_FORMATS=, MATLAB_BIN=/no/such/matlab "$SCRIPT" list

expect_failure "SFT_OUTPUT_DIR may not contain single quotes" \
  env "SFT_OUTPUT_DIR=bad'path" MATLAB_BIN=/no/such/matlab "$SCRIPT" list

echo "render_all argument checks passed."
