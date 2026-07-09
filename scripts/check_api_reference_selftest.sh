#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TEMP_FUNCTION="$ROOT_DIR/src/sftFind.m"

cleanup() {
  rm -f "$TEMP_FUNCTION"
}
trap cleanup EXIT

if [[ -e "$TEMP_FUNCTION" ]]; then
  echo "Temporary self-test function already exists: src/sftFind.m" >&2
  exit 1
fi

cat >"$TEMP_FUNCTION" <<'MATLAB'
function out = sftFind()
out = [];
end
MATLAB

set +e
output="$("$ROOT_DIR/scripts/check_api_reference.sh" 2>&1)"
status=$?
set -e

if [[ "$status" -eq 0 ]]; then
  echo "API reference self-test expected undocumented sftFind to fail." >&2
  exit 1
fi

if [[ "$output" != *"sftFind"* ]]; then
  echo "API reference self-test did not report the missing short symbol." >&2
  printf '%s\n' "$output" >&2
  exit 1
fi

echo "API reference self-test passed."
