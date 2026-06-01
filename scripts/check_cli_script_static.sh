#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SCRIPT="$ROOT_DIR/scripts/render_all.sh"
README="$ROOT_DIR/README.md"
CLI_GUIDE="$ROOT_DIR/docs/matlab-cli-guide.md"

grep -Fq 'SFT_FORMATS="${SFT_FORMATS:-png,svg}"' "$SCRIPT"
grep -Fq 'SFT_OUTPUT_DIR="${SFT_OUTPUT_DIR-gallery}"' "$SCRIPT"
grep -Fq 'print_help()' "$SCRIPT"
grep -Fq './scripts/render_all.sh help' "$SCRIPT"
grep -Fq 'Examples:' "$SCRIPT"
grep -Fq 'SFT_OUTPUT_DIR=/tmp/sft-gallery ./scripts/render_all.sh match inset' "$SCRIPT"
grep -Fq 'format_expr=' "$SCRIPT"
grep -Fq 'sftRenderTags($tag_expr' "$SCRIPT"
grep -Fq 'sftRenderMatches($query_expr' "$SCRIPT"
grep -Fq 'renderCsvExperiment(' "$SCRIPT"
grep -Fq 'runAllExamples(' "$SCRIPT"
grep -Fq 'sftRenderExamples($name_expr' "$SCRIPT"
grep -Fq 'Invalid SFT_FORMATS entry' "$SCRIPT"
grep -Fq 'SFT_OUTPUT_DIR must not be empty' "$SCRIPT"
grep -Fq 'SFT_OUTPUT_DIR may not contain single quotes' "$SCRIPT"
grep -Fq 'SFT_OUTPUT_DIR may not contain control characters' "$SCRIPT"

grep -Fq 'SFT_FORMATS=png,svg,pdf' "$README"
grep -Fq 'SFT_FORMATS=png,svg,pdf' "$CLI_GUIDE"
grep -Fq 'comma-separated list' "$CLI_GUIDE"
grep -Fq 'containing `png`, `svg`, and `pdf`' "$CLI_GUIDE"

echo "CLI script static checks passed."
