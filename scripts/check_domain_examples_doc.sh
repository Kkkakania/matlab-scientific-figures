#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DOC="$ROOT_DIR/docs/domain-examples.md"
README="$ROOT_DIR/README.md"
EXAMPLES_README="$ROOT_DIR/examples/README.md"

if [[ ! -s "$DOC" ]]; then
  echo "missing domain examples documentation: docs/domain-examples.md" >&2
  exit 1
fi

grep -q "# Domain Examples" "$DOC"
grep -q "matlab-scientific-figures#30" "$DOC"
grep -q "pv-power" "$DOC"
grep -q "harmonic-spectrum" "$DOC"
grep -q "renderPvPowerConfidence" "$DOC"
grep -q "renderHarmonicSpectrum" "$DOC"
grep -q "5 MW" "$DOC"
grep -q "% of fundamental" "$DOC"
grep -q "synthetic" "$DOC"
grep -q "Local resource intake" "$DOC"
grep -q "local-resource-intake.md" "$DOC"
grep -q "Signal-processing folders" "$ROOT_DIR/docs/local-resource-intake.md"
grep -q "Electrical-engineering examples" "$ROOT_DIR/docs/local-resource-intake.md"
grep -q "Model-evaluation pack" "$ROOT_DIR/docs/template-backlog.md"
grep -q "Do not attach private datasets" "$DOC"
grep -q "No adoption, download, or approval claims" "$DOC"
grep -q "docs/domain-examples.md" "$README"
grep -q "docs/domain-examples.md" "$EXAMPLES_README"

echo "Domain examples documentation checks passed."
