#!/usr/bin/env bash
set -euo pipefail

OWNER="Kkkakania"
REPOS=(
  "matlab-scientific-figures"
  "matlab-figure-ci"
  "matlab-plotting-skill"
)

usage() {
  cat <<'USAGE'
Usage:
  check_fork_intake_status.sh

Lists visible forks for the three MATLAB plotting repositories and compares each
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

for repo in "${REPOS[@]}"; do
  echo "== $repo visible fork comparisons =="
  forks="$(gh api "repos/$OWNER/$repo/forks" --jq '.[].full_name')"
  if [[ -z "$forks" ]]; then
    echo "no visible forks"
    continue
  fi

  while IFS= read -r fork; do
    [[ -z "$fork" ]] && continue
    branch="$(gh api "repos/$fork" --jq '.default_branch')"
    gh api "repos/$fork/compare/$OWNER:main...$branch" \
      --jq '"status=\(.status) ahead=\(.ahead_by) behind=\(.behind_by) fork='"$fork"' branch='"$branch"'"'
  done <<< "$forks"
done

