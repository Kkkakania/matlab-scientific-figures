#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage:
  check_ecosystem_issue_labels.sh

Checks the interim labels for the open issues that seed the MATLAB figure
ecosystem Project board. This is a live maintainer helper for the period before
the public GitHub Project board is created or verified.

It does not require GitHub Projects scopes; ordinary repository issue read
access is enough. Treat the output as a triage consistency check, not an
adoption metric.
USAGE
}

if [[ "${1:-}" == "--help" || "${1:-}" == "-h" ]]; then
  usage
  exit 0
fi

if [[ $# -gt 0 ]]; then
  echo "Unknown argument: $1" >&2
  usage >&2
  exit 2
fi

if ! command -v gh >/dev/null 2>&1; then
  echo "GitHub CLI is not installed; cannot check ecosystem issue labels." >&2
  exit 2
fi

gh_retry() {
  local attempt=1
  local max_attempts="${GH_RETRY_ATTEMPTS:-3}"
  local delay="${GH_RETRY_DELAY_SECONDS:-1}"
  local output status

  while true; do
    if output="$(gh "$@" 2>&1)"; then
      printf '%s\n' "$output"
      return 0
    fi
    status=$?
    if [[ "$output" != *"EOF"* && "$output" != *"HTTP 5"* && "$output" != *"timeout"* ]] || [[ "$attempt" -ge "$max_attempts" ]]; then
      printf '%s\n' "$output" >&2
      return "$status"
    fi
    sleep "$delay"
    attempt=$((attempt + 1))
  done
}

missing=0

check_issue_labels() {
  local repo="$1"
  local issue="$2"
  shift 2
  local expected=("$@")

  local labels
  labels="$(
    gh_retry issue view "$issue" \
      --repo "Kkkakania/$repo" \
      --json labels \
      --jq '[.labels[].name] | join("\n")'
  )"

  echo "== Kkkakania/$repo#$issue =="
  for label in "${expected[@]}"; do
    if grep -Fxq "$label" <<<"$labels"; then
      echo "OK label: $label"
    else
      echo "MISSING label: $label" >&2
      missing=1
    fi
  done
}

check_issue_labels "matlab-scientific-figures" 31 documentation ci
check_issue_labels "matlab-scientific-figures" 30 template enhancement
check_issue_labels "matlab-scientific-figures" 9 first-use "help wanted" "good first issue" question
check_issue_labels "matlab-figure-ci" 1 enhancement
check_issue_labels "matlab-plotting-skill" 11 testing feedback
check_issue_labels "python-plotting-skill" 1 documentation question
check_issue_labels "python-plotting-skill" 2 enhancement "good first issue"

if [[ "$missing" -ne 0 ]]; then
  echo "One or more interim triage labels are missing." >&2
  exit 1
fi

echo "Ecosystem issue label checks passed."
