#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

for script in "$ROOT_DIR/scripts/check_privacy.sh" "$ROOT_DIR/scripts/check_provenance.sh"; do
  if ! grep -q "mktemp" "$script"; then
    echo "${script#$ROOT_DIR/} should use mktemp for scan matches." >&2
    exit 1
  fi
  if ! grep -q "trap 'rm -f" "$script"; then
    echo "${script#$ROOT_DIR/} should clean scan matches with trap." >&2
    exit 1
  fi
  if grep -q "/tmp/sft_.*\\.\\$\\$" "$script"; then
    echo "${script#$ROOT_DIR/} uses a predictable /tmp filename." >&2
    exit 1
  fi
done

echo "Scan script tempfile checks passed."
