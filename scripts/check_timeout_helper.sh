#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$ROOT_DIR/scripts/_run_with_timeout.sh"

run_with_timeout 2 bash -c 'exit 0'

set +e
run_with_timeout 0.2 bash -c 'sleep 3'
timeout_status=$?
set -e

if [[ "$timeout_status" -ne 124 ]]; then
  echo "Expected timeout status 124, got $timeout_status" >&2
  exit 1
fi

set +e
run_with_timeout 0.0 bash -c 'sleep 0.1; exit 0'
zero_timeout_status=$?
set -e

if [[ "$zero_timeout_status" -ne 0 ]]; then
  echo "Expected decimal zero timeout to disable the guard, got $zero_timeout_status" >&2
  exit 1
fi

set +e
run_with_timeout bad bash -c 'exit 0'
invalid_status=$?
set -e

if [[ "$invalid_status" -ne 2 ]]; then
  echo "Expected invalid timeout status 2, got $invalid_status" >&2
  exit 1
fi

echo "Timeout helper checks passed."
