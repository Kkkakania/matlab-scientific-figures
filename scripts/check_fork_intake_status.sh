#!/usr/bin/env bash
set -euo pipefail

OWNER="Kkkakania"
REPOS=(
  "matlab-scientific-figures"
  "matlab-figure-ci"
  "matlab-plotting-skill"
  "python-plotting-skill"
)

usage() {
  cat <<'USAGE'
Usage:
  check_fork_intake_status.sh

Lists visible forks for the tracked plotting repositories and compares each
fork's default branch against upstream main.

This is a live maintainer helper, not a CI requirement. A fork with ahead=0 has
no visible commits to review from that default branch; it should be treated as
an awareness signal, not adoption or pending contribution evidence.
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
  echo "GitHub CLI is not installed; cannot check visible forks." >&2
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

for repo in "${REPOS[@]}"; do
  echo "== $repo visible fork comparisons =="
  forks="$(gh_retry api "repos/$OWNER/$repo/forks" --jq '.[].full_name')"
  if [[ -z "$forks" ]]; then
    echo "no visible forks"
    continue
  fi

  while IFS= read -r fork; do
    [[ -z "$fork" ]] && continue
    branch="$(gh_retry api "repos/$fork" --jq '.default_branch')"
    gh_retry api "repos/$fork/compare/$OWNER:main...$branch" \
      --jq '"status=\(.status) ahead=\(.ahead_by) behind=\(.behind_by) fork='"$fork"' branch='"$branch"'"'
  done <<< "$forks"
done
