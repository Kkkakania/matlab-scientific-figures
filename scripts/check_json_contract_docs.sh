#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

DOC="$ROOT_DIR/docs/json-envelope-compatibility.md"

if [[ ! -f "$DOC" ]]; then
  echo "Missing docs/json-envelope-compatibility.md." >&2
  exit 1
fi

grep -Fq "[JSON envelope compatibility](json-envelope-compatibility.md)" "$ROOT_DIR/docs/README.md"
grep -Fq "[JSON envelope compatibility](json-envelope-compatibility.md)" "$ROOT_DIR/docs/ecosystem-status.md"
grep -Fq "flat diagnostic" "$DOC"
grep -Fq "wrapper envelope" "$DOC"
grep -Fq "normalizeFigureJson" "$DOC"
grep -Fq "consumers should not break" "$DOC"

echo "JSON contract documentation checks passed."
