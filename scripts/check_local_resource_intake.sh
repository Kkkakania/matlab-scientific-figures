#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DOC="$ROOT_DIR/docs/local-resource-intake.md"
BACKLOG="$ROOT_DIR/docs/template-backlog.md"

grep -q "Private Prototype Library Snapshot" "$DOC"
grep -q "216 Python templates" "$DOC"
grep -q "27 palette families" "$DOC"
grep -q "Origin Python and LabTalk scripts" "$DOC"
grep -q "public template still needs a normal issue" "$DOC"
grep -q "does not prove adoption" "$DOC"

grep -q "Prototype-Derived Triage Notes" "$BACKLOG"
grep -q "more than 200 figure ideas" "$BACKLOG"
grep -q "not to import that" "$BACKLOG"
grep -q "Origin interoperability notes" "$BACKLOG"

grep -q "Local resource intake" "$ROOT_DIR/docs/quality-gates.md"
grep -q "check_local_resource_intake.sh" "$ROOT_DIR/docs/quality-gates.md"
grep -q "clean-room promotion rules" "$ROOT_DIR/docs/quality-gates.md"

echo "Local resource intake checks passed."
