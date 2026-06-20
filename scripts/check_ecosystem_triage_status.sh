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
  check_ecosystem_triage_status.sh

Lists open issues and open pull requests for the tracked plotting repositories.
This is a live maintainer helper for the period before the GitHub Project board
is created or verified.

It does not require GitHub Projects scopes; ordinary repository read access is
enough. Treat the output as a triage snapshot, not an adoption metric.
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
  echo "GitHub CLI is not installed; cannot check ecosystem triage status." >&2
  exit 2
fi

for repo in "${REPOS[@]}"; do
  full="$OWNER/$repo"
  echo "== $full open issues =="
  gh issue list \
    --repo "$full" \
    --state open \
    --limit 50 \
    --json number,title,labels,updatedAt \
    --jq '.[] | "#\(.number) \(.title) [labels: \([.labels[].name] | join(", "))] updated=\(.updatedAt)"'

  echo "== $full open pull requests =="
  gh pr list \
    --repo "$full" \
    --state open \
    --limit 50 \
    --json number,title,headRefName,updatedAt \
    --jq '.[] | "#\(.number) \(.title) [head: \(.headRefName)] updated=\(.updatedAt)"'
done
