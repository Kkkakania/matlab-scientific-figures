#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PATTERN="$(sed -n "s/^PATTERN='\(.*\)'$/\1/p" "$ROOT_DIR/scripts/check_provenance.sh")"

if [[ -z "$PATTERN" ]]; then
  echo "Could not read provenance pattern." >&2
  exit 1
fi

check_match() {
  local sample="$1"
  if ! grep -Eq "$PATTERN" <<<"$sample"; then
    echo "provenance pattern should match: $sample" >&2
    exit 1
  fi
}

author_marker="auth""or:"
license_token="gp""l"
ak_marker="ak""un"
cn_marker="cs""dn"
stackoverflow_marker="Stack ""Overflow"
exchange_marker="stack""Exchange"
gist_marker="GitHub ""Gist"
dataset_marker="Ka""ggle"

check_match "$author_marker copied source"
check_match "$license_token copied source"
check_match "$ak_marker copied source"
check_match "$cn_marker copied source"
check_match "$stackoverflow_marker copied source"
check_match "$exchange_marker copied source"
check_match "$gist_marker copied source"
check_match "$dataset_marker copied source"

echo "Provenance pattern self-test passed."
