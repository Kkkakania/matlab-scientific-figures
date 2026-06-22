#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SANDBOX="$ROOT_DIR/.forbidden-file-selftest"

rm -rf "$SANDBOX"
mkdir -p "$SANDBOX/.venv" "$SANDBOX/work" "$SANDBOX/package.egg-info"
touch \
  "$SANDBOX/.mfigci-results.json" \
  "$SANDBOX/example.mexmaci64" \
  "$SANDBOX/mfigci-report.md" \
  "$SANDBOX/package.egg-info/PKG-INFO"

cleanup() {
  rm -rf "$SANDBOX"
}
trap cleanup EXIT

set +e
output="$("$ROOT_DIR/scripts/check_forbidden_files.sh" 2>&1)"
status=$?
set -e

if [[ "$status" -eq 0 ]]; then
  echo "forbidden-file self-test expected failure, got success" >&2
  exit 1
fi

for expected in ".venv" "work" ".mfigci-results.json" "mfigci-report.md" "package.egg-info" "example.mexmaci64"; do
  if [[ "$output" != *"$expected"* ]]; then
    echo "forbidden-file self-test missing expected marker: $expected" >&2
    printf '%s\n' "$output" >&2
    exit 1
  fi
done

echo "Forbidden file self-test passed."
