#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

"$SCRIPT_DIR/check_application_live_snapshot_retry.sh"
echo "Codex application live snapshot retry compatibility check passed."
