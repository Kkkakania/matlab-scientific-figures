#!/usr/bin/env bash
set -euo pipefail

OUTPUT_DIR=""
COMMAND_TEXT=""
MATLAB_VERSION=""
OS_NAME=""
COMMIT_REF=""
TEMPLATE_SUBSET=""
FORMATS=""
QUICK_START_RESULT=""
DISCOVERY_RESULT=""
RENDERING_RESULT=""
HELPER_RESULT=""

usage() {
  cat <<'USAGE'
Usage:
  collect_first_use_feedback.sh [options]

Options:
  --output-dir <dir>      Scratch output directory to summarize.
  --command <text>        Command sequence to include in the draft.
  --matlab <text>         MATLAB version or launch detail.
  --os <text>             Operating system.
  --commit <text>         Fresh-clone commit or branch tested.
  --templates <text>      Template subset rendered.
  --formats <text>        Output formats used.
  --quick-start <text>    Quick start result.
  --discovery <text>      Template discovery result.
  --rendering <text>      Rendering result.
  --helper <text>         CLI/helper script result.

Creates a redacted Markdown draft for matlab-scientific-figures#9.
USAGE
}

require_value() {
  local option="$1"
  local value="${2:-}"

  if [[ -z "$value" || "$value" == --* ]]; then
    echo "$option requires a value." >&2
    usage >&2
    exit 2
  fi
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --output-dir)
      require_value "$1" "${2:-}"
      OUTPUT_DIR="$2"
      shift 2
      ;;
    --command)
      require_value "$1" "${2:-}"
      COMMAND_TEXT="$2"
      shift 2
      ;;
    --matlab)
      require_value "$1" "${2:-}"
      MATLAB_VERSION="$2"
      shift 2
      ;;
    --os)
      require_value "$1" "${2:-}"
      OS_NAME="$2"
      shift 2
      ;;
    --commit)
      require_value "$1" "${2:-}"
      COMMIT_REF="$2"
      shift 2
      ;;
    --templates)
      require_value "$1" "${2:-}"
      TEMPLATE_SUBSET="$2"
      shift 2
      ;;
    --formats)
      require_value "$1" "${2:-}"
      FORMATS="$2"
      shift 2
      ;;
    --quick-start)
      require_value "$1" "${2:-}"
      QUICK_START_RESULT="$2"
      shift 2
      ;;
    --discovery)
      require_value "$1" "${2:-}"
      DISCOVERY_RESULT="$2"
      shift 2
      ;;
    --rendering)
      require_value "$1" "${2:-}"
      RENDERING_RESULT="$2"
      shift 2
      ;;
    --helper)
      require_value "$1" "${2:-}"
      HELPER_RESULT="$2"
      shift 2
      ;;
    --help|-h)
      usage
      exit 0
      ;;
    *)
      echo "Unknown argument: $1" >&2
      usage >&2
      exit 2
      ;;
  esac
done

redact() {
  python3 -c 'import re, sys
text = sys.stdin.read()
patterns = [
    "/" + r"Users/[^\s\"'\'')]+",
    "/" + r"home/[^\s\"'\'')]+",
    "C:" + r"\\Users\\[^\s\"'\'')]+",
    r"[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}",
]
for pattern in patterns:
    text = re.sub(pattern, "<redacted-path>", text)
print(text, end="")'
}

summarize_output_dir() {
  local dir="$1"

  if [[ -z "$dir" ]]; then
    echo "not provided"
    return
  fi
  if [[ ! -d "$dir" ]]; then
    echo "not found: $dir"
    return
  fi

  find "$dir" -maxdepth 1 -type f \( -name '*.png' -o -name '*.svg' -o -name '*.pdf' -o -name 'figure_report.md' -o -name 'figure_report.json' \) \
    -print | sed "s#^$dir/##" | sort | head -40
}

extract_report_summary() {
  local dir="$1"
  local report="$dir/figure_report.md"

  if [[ -z "$dir" || ! -f "$report" ]]; then
    echo "not available"
    return
  fi

  sed -n '1,40p' "$report"
}

OUTPUT_SUMMARY="$(summarize_output_dir "$OUTPUT_DIR")"
REPORT_SUMMARY="$(extract_report_summary "$OUTPUT_DIR")"

cat <<REPORT | redact
# First-use feedback draft

OS: ${OS_NAME:-unknown}
MATLAB: ${MATLAB_VERSION:-unknown}
Commit: ${COMMIT_REF:-unknown}
Command sequence:
\`\`\`bash
${COMMAND_TEXT:-not provided}
\`\`\`
Template subset rendered: ${TEMPLATE_SUBSET:-unknown}
Output formats: ${FORMATS:-unknown}
Quick start result: ${QUICK_START_RESULT:-unknown}
Template discovery result: ${DISCOVERY_RESULT:-unknown}
Rendering result: ${RENDERING_RESULT:-unknown}
CLI/helper script result: ${HELPER_RESULT:-unknown}

Output directory summary:
\`\`\`text
${OUTPUT_SUMMARY}
\`\`\`

figure_report.md summary:
\`\`\`text
${REPORT_SUMMARY}
\`\`\`

Expected result:

Actual result:

Most confusing part:

Most useful missing template:

Private details redacted: yes
REPORT
