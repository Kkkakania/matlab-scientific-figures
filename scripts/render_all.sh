#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
MATLAB_BIN="${MATLAB_BIN:-matlab}"

cd "$ROOT_DIR"
"$MATLAB_BIN" -batch "addpath(genpath('src')); addpath(genpath('examples')); runAllExamples('gallery')"
