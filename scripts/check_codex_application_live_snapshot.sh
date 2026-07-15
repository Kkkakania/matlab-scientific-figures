#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
APPLICATION_SNAPSHOT_LABEL="Codex application live snapshot" \
  exec "$SCRIPT_DIR/check_application_live_snapshot.sh" "$@"
