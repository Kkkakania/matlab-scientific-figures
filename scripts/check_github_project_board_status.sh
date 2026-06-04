#!/usr/bin/env bash
set -euo pipefail

OWNER="Kkkakania"
BOARD_NAME="MATLAB Scientific Figure Ecosystem"
ALLOW_PENDING=0

usage() {
  cat <<'USAGE'
Usage:
  check_github_project_board_status.sh [--owner LOGIN] [--board NAME] [--allow-pending]

Checks whether the configured GitHub Projects board is visible to gh.

This is a live maintainer helper, not a CI requirement. It requires a gh token
with GitHub Projects scopes. Use --allow-pending when documenting the current
state on machines that have repository scopes but not read:project/project.
USAGE
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --owner)
      OWNER="${2:?missing owner}"
      shift 2
      ;;
    --board)
      BOARD_NAME="${2:?missing board name}"
      shift 2
      ;;
    --allow-pending)
      ALLOW_PENDING=1
      shift
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

if ! command -v gh >/dev/null 2>&1; then
  echo "GitHub CLI is not installed; cannot check the live Project board." >&2
  exit 2
fi

tmp_err="$(mktemp)"
trap 'rm -f "$tmp_err"' EXIT

if ! project_url="$(
  gh project list \
    --owner "$OWNER" \
    --limit 100 \
    --format json \
    --jq ".projects[] | select(.title == \"$BOARD_NAME\") | .url" \
    2>"$tmp_err"
)"; then
  if grep -Eq 'read:project|project' "$tmp_err"; then
    echo "GitHub Projects scope is missing for gh. Run:" >&2
    echo "  gh auth refresh -s read:project -s project" >&2
    if [[ "$ALLOW_PENDING" -eq 1 ]]; then
      echo "Project board status: pending because gh cannot read Projects yet."
      exit 0
    fi
  else
    echo "Could not list GitHub Projects for $OWNER." >&2
    sed 's/gho_[A-Za-z0-9_]*/gho_<redacted>/g' "$tmp_err" >&2
  fi
  exit 2
fi

if [[ -z "$project_url" ]]; then
  echo "Project board not found: $BOARD_NAME" >&2
  echo "Create it from docs/github-project-board.md, then link the URL to issue #31." >&2
  if [[ "$ALLOW_PENDING" -eq 1 ]]; then
    echo "Project board status: pending because the board is not visible yet."
    exit 0
  fi
  exit 1
fi

echo "Project board found: $project_url"

