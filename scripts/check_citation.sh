#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CITATION_FILE="$ROOT_DIR/CITATION.cff"

if [[ ! -f "$CITATION_FILE" ]]; then
  echo "CITATION.cff is missing." >&2
  exit 1
fi

required_patterns=(
  '^cff-version:'
  '^message:'
  '^type: software$'
  '^title:'
  '^authors:'
  '^repository-code:'
  '^license:'
  '^version:'
  '^date-released:'
)

missing=0
for pattern in "${required_patterns[@]}"; do
  if ! grep -Eq "$pattern" "$CITATION_FILE"; then
    echo "CITATION.cff missing required pattern: $pattern" >&2
    missing=1
  fi
done

readme_version="$(sed -nE 's/^Current public release: `(v[0-9]+\.[0-9]+\.[0-9]+)`\.$/\1/p' "$ROOT_DIR/README.md" | head -n 1)"
citation_version="$(sed -nE 's/^version: "?v?([0-9]+\.[0-9]+\.[0-9]+)"?$/\1/p' "$CITATION_FILE" | head -n 1)"

if [[ -z "$readme_version" ]]; then
  echo "Could not find current public release in README.md." >&2
  missing=1
fi

if [[ -z "$citation_version" ]]; then
  echo "Could not find semantic version in CITATION.cff." >&2
  missing=1
fi

if [[ -n "$readme_version" && -n "$citation_version" && "${readme_version#v}" != "$citation_version" ]]; then
  echo "Citation version mismatch: README has $readme_version, CITATION.cff has $citation_version." >&2
  missing=1
fi

if [[ "$missing" -ne 0 ]]; then
  exit 1
fi

echo "Citation metadata is present."
