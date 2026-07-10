#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SANDBOX="$ROOT_DIR/.privacy-selftest"

rm -rf "$SANDBOX"
mkdir -p "$SANDBOX"
cat >"$SANDBOX/leaks.md" <<'EOF'
contact = person@example.com
mac_path = /Users/example/Desktop/private-data
linux_path = /home/example/private-data
wsl_path = /mnt/c/Users/example/private-data
windows_path = C:\Users\example\private-data
profile_path = %USERPROFILE%\private-data
codespaces_path = /workspaces/private-repo/private-data
external_volume = /Volumes/External/private-data
EOF

cleanup() {
  rm -rf "$SANDBOX"
}
trap cleanup EXIT

set +e
output="$("$ROOT_DIR/scripts/check_privacy.sh" 2>&1)"
status=$?
set -e

if [[ "$status" -eq 0 ]]; then
  echo "privacy self-test expected failure, got success" >&2
  exit 1
fi

for expected in \
  "person@example.com" \
  "/Users/example/Desktop/private-data" \
  "/home/example/private-data" \
  "/mnt/c/Users/example/private-data" \
  "C:\\Users\\example\\private-data" \
  "%USERPROFILE%\\private-data" \
  "/workspaces/private-repo/private-data" \
  "/Volumes/External/private-data"; do
  if [[ "$output" != *"$expected"* ]]; then
    echo "privacy self-test missing expected marker: $expected" >&2
    printf '%s\n' "$output" >&2
    exit 1
  fi
done

echo "Privacy self-test passed."
