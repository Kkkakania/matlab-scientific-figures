#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
exec python3 "$ROOT_DIR/scripts/sync_template_reference.py" \
  --manifest "$ROOT_DIR/docs/template-manifest.json" \
  --reference "$ROOT_DIR/docs/template-reference.md" \
  --check
