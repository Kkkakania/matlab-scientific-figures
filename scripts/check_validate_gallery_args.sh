#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SCRIPT="$ROOT_DIR/scripts/validate_gallery.sh"
TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

expect_failure() {
  local expected="$1"
  shift
  local err_file="$TMP_DIR/err.txt"
  local status

  set +e
  "$@" >/dev/null 2>"$err_file"
  status=$?
  set -e

  if [[ "$status" -ne 2 ]]; then
    echo "expected exit 2, got $status" >&2
    cat "$err_file" >&2
    exit 1
  fi

  grep -q "$expected" "$err_file"
}

expect_failure "Output directory may not contain single quotes" \
  env MATLAB_BIN=/no/such/matlab "$SCRIPT" "bad'path"

expect_failure "Output directory may not contain control characters" \
  env MATLAB_BIN=/no/such/matlab "$SCRIPT" $'bad\npath'

echo "validate_gallery argument checks passed."
