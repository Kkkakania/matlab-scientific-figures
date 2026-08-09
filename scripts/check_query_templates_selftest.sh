#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
QUERY="$ROOT_DIR/scripts/query_templates.py"
MANIFEST="$ROOT_DIR/docs/template-manifest.json"

payload="$(python3 "$QUERY" --manifest "$MANIFEST" --tag uncertainty --json)"
python3 - "$payload" <<'PY'
import json
import sys

payload = json.loads(sys.argv[1])
assert payload["schemaVersion"] == 1
assert payload["matchCount"] == len(payload["templates"])
assert payload["matchCount"] > 0
assert all("uncertainty" in item["Tags"] for item in payload["templates"])
PY

python3 "$QUERY" --manifest "$MANIFEST" --name line_plot | grep -Fq '`line_plot`'

if python3 "$QUERY" --manifest "$MANIFEST" --name does_not_exist >/dev/null 2>&1; then
  echo "unknown exact template name should fail" >&2
  exit 1
fi

echo "template query self-test passed."
