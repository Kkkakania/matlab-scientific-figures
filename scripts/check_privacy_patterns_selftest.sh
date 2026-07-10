#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

PATTERN="$(sed -n "s/^PATTERN='\(.*\)'/\1/p" scripts/check_privacy.sh)"

expect_match() {
  local sample="$1"
  if ! printf '%s\n' "$sample" | grep -Eq "$PATTERN"; then
    echo "Expected privacy pattern to match: $sample" >&2
    exit 1
  fi
}

platform_marker="cs""dn"
mixed_platform_marker="cS""dN"
chat_marker="We""CHAT"

expect_match "$platform_marker"
expect_match "$mixed_platform_marker"
expect_match "$chat_marker"

echo "Privacy pattern self-test passed."
