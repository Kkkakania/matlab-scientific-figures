#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SANDBOX="$ROOT_DIR/.docs-link-selftest"

rm -rf "$SANDBOX"
mkdir -p "$SANDBOX"

cleanup() {
  rm -rf "$SANDBOX"
}
trap cleanup EXIT

cat >"$SANDBOX/README.md" <<'MD'
Inline examples should not be treated as real docs links:

`[missing](missing.md)`

Real links should still be checked: [project README](../README.md)
MD

set +e
output="$("$ROOT_DIR/scripts/check_docs_links.sh" 2>&1)"
status=$?
set -e

if [[ "$status" -ne 0 ]]; then
  echo "docs-link self-test expected inline code links to be ignored." >&2
  printf '%s\n' "$output" >&2
  exit 1
fi

cat >"$SANDBOX/README.md" <<'MD'
Real broken links should still fail: [missing](missing.md)
MD

set +e
output="$("$ROOT_DIR/scripts/check_docs_links.sh" 2>&1)"
status=$?
set -e

if [[ "$status" -eq 0 ]]; then
  echo "docs-link self-test expected a real broken link failure." >&2
  exit 1
fi

if [[ "$output" != *"missing.md"* ]]; then
  echo "docs-link self-test did not report the broken link target." >&2
  printf '%s\n' "$output" >&2
  exit 1
fi

echo "Documentation link self-test passed."
