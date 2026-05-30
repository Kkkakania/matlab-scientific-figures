#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
MATLAB_BIN="${MATLAB_BIN:-matlab}"
REQUIRE_MATLAB="${REQUIRE_MATLAB:-0}"
SFT_MATLAB_TIMEOUT_SECONDS="${SFT_MATLAB_TIMEOUT_SECONDS:-600}"

source "$ROOT_DIR/scripts/_run_with_timeout.sh"

cd "$ROOT_DIR"

run_step() {
  local label="$1"
  shift
  echo "==> $label"
  "$@"
}

matlab_available() {
  if [[ "$MATLAB_BIN" == */* ]]; then
    [[ -x "$MATLAB_BIN" ]]
  else
    command -v "$MATLAB_BIN" >/dev/null 2>&1
  fi
}

run_step "gallery outputs" ./scripts/check_gallery_outputs.sh
run_step "gallery metadata consistency" ./scripts/check_gallery_consistency.sh
run_step "version metadata consistency" ./scripts/check_version_consistency.sh
run_step "citation metadata" ./scripts/check_citation.sh
run_step "documentation links" ./scripts/check_docs_links.sh
run_step "API reference coverage" ./scripts/check_api_reference.sh
run_step "MATLAB help text" ./scripts/check_matlab_help.sh
run_step "README gallery preview" ./scripts/check_readme_gallery.sh
run_step "timeout helper" ./scripts/check_timeout_helper.sh
run_step "forbidden file scan" ./scripts/check_forbidden_files.sh
run_step "privacy scan" ./scripts/check_privacy.sh
run_step "provenance scan" ./scripts/check_provenance.sh

if matlab_available; then
  run_step "template manifest consistency" env MATLAB_BIN="$MATLAB_BIN" ./scripts/check_template_manifest.sh
  run_step "MATLAB core tests" run_with_timeout "$SFT_MATLAB_TIMEOUT_SECONDS" "$MATLAB_BIN" -batch \
    "addpath(genpath('src')); addpath(genpath('examples')); results = [runtests('tests/test_sft_core.m'), runtests('tests/test_run_all_examples.m')]; assertSuccess(results);"
  run_step "MATLAB CLI commands" env MATLAB_BIN="$MATLAB_BIN" ./scripts/check_cli_commands.sh
else
  if [[ "$REQUIRE_MATLAB" == "1" ]]; then
    echo "MATLAB executable not found: $MATLAB_BIN" >&2
    exit 127
  fi
  echo "==> MATLAB checks skipped; set MATLAB_BIN or REQUIRE_MATLAB=1 to enforce them."
fi

echo "Release checks passed."
