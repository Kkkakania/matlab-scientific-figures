#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DOC="$ROOT_DIR/docs/github-project-board.md"
HELPER="$ROOT_DIR/scripts/check_github_project_board_status.sh"

if [[ ! -s "$DOC" ]]; then
  echo "Missing docs/github-project-board.md." >&2
  exit 1
fi

if [[ ! -x "$HELPER" ]]; then
  echo "Missing executable scripts/check_github_project_board_status.sh." >&2
  exit 1
fi

grep -Fq "MATLAB Scientific Figure Ecosystem" "$DOC"
grep -Fq "matlab-scientific-figures#31" "$DOC"
grep -Fq "gh auth refresh -s read:project -s project" "$DOC"
grep -Fq "./scripts/check_github_project_board_status.sh --allow-pending" "$DOC"
grep -Fq "matlab-scientific-figures#9" "$DOC"
grep -Fq "matlab-scientific-figures#30" "$DOC"
grep -Fq "matlab-figure-ci#1" "$DOC"
grep -Fq "matlab-plotting-skill#11" "$DOC"

if grep -Fq "matlab-plotting-skill#16" "$DOC"; then
  echo "docs/github-project-board.md still references closed issue matlab-plotting-skill#16." >&2
  exit 1
fi

echo "GitHub Project board documentation checks passed."

