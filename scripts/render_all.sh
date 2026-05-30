#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
MATLAB_BIN="${MATLAB_BIN:-matlab}"
SFT_OUTPUT_DIR="${SFT_OUTPUT_DIR:-gallery}"
SFT_MATLAB_TIMEOUT_SECONDS="${SFT_MATLAB_TIMEOUT_SECONDS:-600}"

source "$ROOT_DIR/scripts/_run_with_timeout.sh"

if [[ "$MATLAB_BIN" == */* ]]; then
  if [[ ! -x "$MATLAB_BIN" ]]; then
    echo "MATLAB executable not found: $MATLAB_BIN" >&2
    echo "Set MATLAB_BIN to the full MATLAB executable path." >&2
    exit 127
  fi
elif ! command -v "$MATLAB_BIN" >/dev/null 2>&1; then
  echo "MATLAB executable not found: $MATLAB_BIN" >&2
  echo "Try: MATLAB_BIN=/Applications/MATLAB_R2025a.app/bin/matlab ./scripts/render_all.sh" >&2
  exit 127
fi

cd "$ROOT_DIR"

if [[ "${1:-}" == "list" ]]; then
  if [[ "$#" -ne 1 ]]; then
    echo "Usage: ./scripts/render_all.sh list" >&2
    exit 2
  fi
  run_with_timeout "$SFT_MATLAB_TIMEOUT_SECONDS" "$MATLAB_BIN" -batch "addpath(genpath('src')); addpath(genpath('examples')); disp(sftListTemplates())"
  exit 0
fi

if [[ "${1:-}" == "tags" ]]; then
  if [[ "$#" -ne 1 ]]; then
    echo "Usage: ./scripts/render_all.sh tags" >&2
    exit 2
  fi
  run_with_timeout "$SFT_MATLAB_TIMEOUT_SECONDS" "$MATLAB_BIN" -batch "addpath(genpath('src')); addpath(genpath('examples')); disp(sftListTags())"
  exit 0
fi

if [[ "${1:-}" == "search" ]]; then
  shift
  if [[ "$#" -eq 0 ]]; then
    echo "Usage: ./scripts/render_all.sh search <keyword> [keyword...]" >&2
    exit 2
  fi

  queries=()
  for query in "$@"; do
    if [[ ! "$query" =~ ^[A-Za-z0-9_-]+$ ]]; then
      echo "Invalid search keyword: $query" >&2
      echo "Search keywords may contain letters, numbers, hyphens, and underscores." >&2
      exit 2
    fi
    queries+=("\"$query\"")
  done

  query_expr="[$(IFS=,; echo "${queries[*]}")]"
  run_with_timeout "$SFT_MATLAB_TIMEOUT_SECONDS" "$MATLAB_BIN" -batch "addpath(genpath('src')); addpath(genpath('examples')); disp(sftFindTemplates($query_expr))"
  exit 0
fi

if [[ "${1:-}" == "match" ]]; then
  shift
  if [[ "$#" -eq 0 ]]; then
    echo "Usage: ./scripts/render_all.sh match <keyword> [keyword...]" >&2
    exit 2
  fi

  queries=()
  for query in "$@"; do
    if [[ ! "$query" =~ ^[A-Za-z0-9_-]+$ ]]; then
      echo "Invalid match keyword: $query" >&2
      echo "Match keywords may contain letters, numbers, hyphens, and underscores." >&2
      exit 2
    fi
    queries+=("\"$query\"")
  done

  query_expr="[$(IFS=,; echo "${queries[*]}")]"
  run_with_timeout "$SFT_MATLAB_TIMEOUT_SECONDS" "$MATLAB_BIN" -batch "addpath(genpath('src')); addpath(genpath('examples')); result = sftRenderMatches($query_expr, '$SFT_OUTPUT_DIR'); disp('Rendered templates:'); disp(string({result.name})')"
  exit 0
fi

if [[ "$#" -eq 0 ]]; then
  run_with_timeout "$SFT_MATLAB_TIMEOUT_SECONDS" "$MATLAB_BIN" -batch "addpath(genpath('src')); addpath(genpath('examples')); runAllExamples('$SFT_OUTPUT_DIR')"
  exit 0
fi

names=()
for name in "$@"; do
  if [[ ! "$name" =~ ^[a-z0-9_]+$ ]]; then
    echo "Invalid template name: $name" >&2
    echo "Template names may contain lowercase letters, numbers, and underscores." >&2
    exit 2
  fi
  names+=("\"$name\"")
done

name_expr="[$(IFS=,; echo "${names[*]}")]"
run_with_timeout "$SFT_MATLAB_TIMEOUT_SECONDS" "$MATLAB_BIN" -batch "addpath(genpath('src')); addpath(genpath('examples')); sftRenderExamples($name_expr, '$SFT_OUTPUT_DIR')"
