#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PATTERN="$(sed -n "s/^PATTERN='\(.*\)'$/\1/p" "$ROOT_DIR/scripts/check_privacy.sh")"

if [[ -z "$PATTERN" ]]; then
  echo "Could not read privacy pattern." >&2
  exit 1
fi

check_match() {
  local sample="$1"
  if ! grep -Eq "$PATTERN" <<<"$sample"; then
    echo "privacy pattern should match: $sample" >&2
    exit 1
  fi
}

mac_root="/"Users
linux_root="/"home
windows_root="C:""\\""Users""\\"

check_match "$mac_root/alice/private/project/data.csv"
check_match "$linux_root/alice/private/project/data.csv"
check_match "${windows_root}Alice\\private\\project\\data.csv"

echo "Privacy pattern self-test passed."
