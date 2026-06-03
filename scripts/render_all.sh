#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
MATLAB_BIN="${MATLAB_BIN:-matlab}"
SFT_OUTPUT_DIR="${SFT_OUTPUT_DIR-gallery}"
SFT_FORMATS="${SFT_FORMATS:-png,svg}"
SFT_MATLAB_TIMEOUT_SECONDS="${SFT_MATLAB_TIMEOUT_SECONDS:-600}"

source "$ROOT_DIR/scripts/_run_with_timeout.sh"

print_help() {
  cat <<'HELP'
Usage: ./scripts/render_all.sh [command|template...]

Commands:
  help                         Show this help text.
  list                         List available templates.
  tags                         List available tags.
  search <keyword> [...]       Search templates by name, task, or tag.
  info <template>              Show metadata for one template.
  tag <tag> [...]              Render templates with exact tag matches.
  match <keyword> [...]        Render templates matching search keywords.
  csv-example                  Render the bundled CSV example.
  pv-power                     Render the synthetic PV power domain example.
  <template> [...]             Render selected templates.
  (no arguments)               Render the full gallery.

Environment:
  MATLAB_BIN                   MATLAB executable. Default: matlab
  SFT_OUTPUT_DIR               Output directory. Default: gallery
  SFT_FORMATS                  Comma-separated png,svg,pdf list. Default: png,svg
  SFT_MATLAB_TIMEOUT_SECONDS   Per-command timeout. Default: 600

Examples:
  ./scripts/render_all.sh list
  ./scripts/render_all.sh search matrix
  ./scripts/render_all.sh heatmap radar_chart
  SFT_OUTPUT_DIR=/tmp/sft-gallery ./scripts/render_all.sh match inset
  SFT_FORMATS=png,svg,pdf ./scripts/render_all.sh tag matrix
  ./scripts/render_all.sh pv-power
HELP
}

if [[ "${1:-}" == "help" || "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
  if [[ "$#" -ne 1 ]]; then
    echo "Usage: ./scripts/render_all.sh help" >&2
    exit 2
  fi
  print_help
  exit 0
fi

if [[ -z "$SFT_OUTPUT_DIR" ]]; then
  echo "SFT_OUTPUT_DIR must not be empty." >&2
  exit 2
fi

if [[ "$SFT_OUTPUT_DIR" == *"'"* ]]; then
  echo "SFT_OUTPUT_DIR may not contain single quotes." >&2
  exit 2
fi

if [[ "$SFT_OUTPUT_DIR" =~ [[:cntrl:]] ]]; then
  echo "SFT_OUTPUT_DIR may not contain control characters." >&2
  exit 2
fi

formats=()
IFS=',' read -r -a requested_formats <<<"$SFT_FORMATS"
for format in "${requested_formats[@]}"; do
  format="${format//[[:space:]]/}"
  if [[ -z "$format" ]]; then
    continue
  fi
  if [[ ! "$format" =~ ^(png|svg|pdf)$ ]]; then
    echo "Invalid SFT_FORMATS entry: $format" >&2
    echo "Use a comma-separated list containing png, svg, and/or pdf." >&2
    exit 2
  fi
  formats+=("\"$format\"")
done

if [[ "${#formats[@]}" -eq 0 ]]; then
  echo "SFT_FORMATS must include at least one of: png, svg, pdf." >&2
  exit 2
fi

format_expr="[$(IFS=,; echo "${formats[*]}")]"

validate_tokens() {
  local label="$1"
  local pattern="$2"
  shift 2
  local value

  for value in "$@"; do
    if [[ ! "$value" =~ $pattern ]]; then
      echo "Invalid $label: $value" >&2
      case "$label" in
        "search keyword")
          echo "Search keywords may contain letters, numbers, hyphens, and underscores." >&2
          ;;
        "match keyword")
          echo "Match keywords may contain letters, numbers, hyphens, and underscores." >&2
          ;;
        "tag")
          echo "Tags may contain letters, numbers, hyphens, and underscores." >&2
          ;;
        "template name")
          echo "Template names may contain lowercase letters, numbers, and underscores." >&2
          ;;
      esac
      exit 2
    fi
  done
}

case "${1:-}" in
  list|tags|csv-example|pv-power)
    if [[ "$#" -ne 1 ]]; then
      echo "Usage: ./scripts/render_all.sh ${1}" >&2
      exit 2
    fi
    ;;
  search)
    shift
    if [[ "$#" -eq 0 ]]; then
      echo "Usage: ./scripts/render_all.sh search <keyword> [keyword...]" >&2
      exit 2
    fi
    validate_tokens "search keyword" '^[A-Za-z0-9_-]+$' "$@"
    set -- search "$@"
    ;;
  match)
    shift
    if [[ "$#" -eq 0 ]]; then
      echo "Usage: ./scripts/render_all.sh match <keyword> [keyword...]" >&2
      exit 2
    fi
    validate_tokens "match keyword" '^[A-Za-z0-9_-]+$' "$@"
    set -- match "$@"
    ;;
  tag)
    shift
    if [[ "$#" -eq 0 ]]; then
      echo "Usage: ./scripts/render_all.sh tag <tag> [tag...]" >&2
      exit 2
    fi
    validate_tokens "tag" '^[A-Za-z0-9_-]+$' "$@"
    set -- tag "$@"
    ;;
  info)
    shift
    if [[ "$#" -ne 1 ]]; then
      echo "Usage: ./scripts/render_all.sh info <template>" >&2
      exit 2
    fi
    validate_tokens "template name" '^[a-z0-9_]+$' "$@"
    set -- info "$@"
    ;;
  "")
    ;;
  *)
    validate_tokens "template name" '^[a-z0-9_]+$' "$@"
    ;;
esac

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

  queries=()
  for query in "$@"; do
    queries+=("\"$query\"")
  done

  query_expr="[$(IFS=,; echo "${queries[*]}")]"
  run_with_timeout "$SFT_MATLAB_TIMEOUT_SECONDS" "$MATLAB_BIN" -batch "addpath(genpath('src')); addpath(genpath('examples')); disp(sftFindTemplates($query_expr))"
  exit 0
fi

if [[ "${1:-}" == "info" ]]; then
  shift

  name="$1"

  run_with_timeout "$SFT_MATLAB_TIMEOUT_SECONDS" "$MATLAB_BIN" -batch "addpath(genpath('src')); addpath(genpath('examples')); disp(sftTemplateInfo(\"$name\"))"
  exit 0
fi

if [[ "${1:-}" == "tag" ]]; then
  shift

  tags=()
  for tag in "$@"; do
    tags+=("\"$tag\"")
  done

  tag_expr="[$(IFS=,; echo "${tags[*]}")]"
  run_with_timeout "$SFT_MATLAB_TIMEOUT_SECONDS" "$MATLAB_BIN" -batch "addpath(genpath('src')); addpath(genpath('examples')); result = sftRenderTags($tag_expr, '$SFT_OUTPUT_DIR', $format_expr); disp('Rendered templates:'); disp(string({result.name})')"
  exit 0
fi

if [[ "${1:-}" == "match" ]]; then
  shift

  queries=()
  for query in "$@"; do
    queries+=("\"$query\"")
  done

  query_expr="[$(IFS=,; echo "${queries[*]}")]"
  run_with_timeout "$SFT_MATLAB_TIMEOUT_SECONDS" "$MATLAB_BIN" -batch "addpath(genpath('src')); addpath(genpath('examples')); result = sftRenderMatches($query_expr, '$SFT_OUTPUT_DIR', $format_expr); disp('Rendered templates:'); disp(string({result.name})')"
  exit 0
fi

if [[ "${1:-}" == "csv-example" ]]; then
  run_with_timeout "$SFT_MATLAB_TIMEOUT_SECONDS" "$MATLAB_BIN" -batch "addpath(genpath('src')); addpath(genpath('examples')); renderCsvExperiment('$SFT_OUTPUT_DIR', $format_expr)"
  exit 0
fi

if [[ "${1:-}" == "pv-power" ]]; then
  run_with_timeout "$SFT_MATLAB_TIMEOUT_SECONDS" "$MATLAB_BIN" -batch "addpath(genpath('src')); addpath(genpath('examples')); renderPvPowerConfidence('$SFT_OUTPUT_DIR', $format_expr)"
  exit 0
fi

if [[ "$#" -eq 0 ]]; then
  run_with_timeout "$SFT_MATLAB_TIMEOUT_SECONDS" "$MATLAB_BIN" -batch "addpath(genpath('src')); addpath(genpath('examples')); runAllExamples('$SFT_OUTPUT_DIR', $format_expr)"
  exit 0
fi

names=()
for name in "$@"; do
  names+=("\"$name\"")
done

name_expr="[$(IFS=,; echo "${names[*]}")]"
run_with_timeout "$SFT_MATLAB_TIMEOUT_SECONDS" "$MATLAB_BIN" -batch "addpath(genpath('src')); addpath(genpath('examples')); result = sftRenderExamples($name_expr, '$SFT_OUTPUT_DIR', $format_expr); disp('Rendered templates:'); disp(string({result.name})')"
