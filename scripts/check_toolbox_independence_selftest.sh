#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TMP_FILE="$ROOT_DIR/tests/tmpToolboxCaseSelftest.m"

cleanup() {
  rm -f "$TMP_FILE"
}
trap cleanup EXIT

cat >"$TMP_FILE" <<'MATLAB'
function y = tmpToolboxCaseSelftest(x)
%TMPTOOLBOXCASESELFTEST Temporary toolbox scan fixture.
y = FitDist(x, 'Normal');
end
MATLAB

set +e
output="$("$ROOT_DIR/scripts/check_toolbox_independence.sh" 2>&1)"
status=$?
set -e

if [[ "$status" -eq 0 ]]; then
  echo "toolbox independence self-test expected failure, got success" >&2
  exit 1
fi

if [[ "$output" != *"FitDist"* ]]; then
  echo "toolbox independence self-test missing mixed-case toolbox call" >&2
  printf '%s\n' "$output" >&2
  exit 1
fi

echo "Toolbox independence self-test passed."
