#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DOC="$ROOT_DIR/docs/github-project-board.md"
DOC_ZH="$ROOT_DIR/docs/github-project-board.zh-CN.md"
HELPER="$ROOT_DIR/scripts/check_github_project_board_status.sh"
TRIAGE_HELPER="$ROOT_DIR/scripts/check_ecosystem_triage_status.sh"

if [[ ! -s "$DOC" ]]; then
  echo "Missing docs/github-project-board.md." >&2
  exit 1
fi

if [[ ! -s "$DOC_ZH" ]]; then
  echo "Missing docs/github-project-board.zh-CN.md." >&2
  exit 1
fi

if [[ ! -x "$HELPER" ]]; then
  echo "Missing executable scripts/check_github_project_board_status.sh." >&2
  exit 1
fi

if [[ ! -x "$TRIAGE_HELPER" ]]; then
  echo "Missing executable scripts/check_ecosystem_triage_status.sh." >&2
  exit 1
fi

grep -Fq "MATLAB Scientific Figure Ecosystem" "$DOC"
grep -Fq "matlab-scientific-figures#31" "$DOC"
grep -Fq "gh auth refresh -s read:project -s project" "$DOC"
grep -Fq "./scripts/check_github_project_board_status.sh --allow-pending" "$DOC"
grep -Fq "./scripts/check_ecosystem_triage_status.sh" "$DOC"
grep -Fq "matlab-scientific-figures#9" "$DOC"
grep -Fq "matlab-scientific-figures#30" "$DOC"
grep -Fq "matlab-figure-ci#1" "$DOC"
grep -Fq "matlab-plotting-skill#11" "$DOC"

grep -Fq "GitHub Project 看板设置说明" "$DOC_ZH"
grep -Fq "MATLAB Scientific Figure Ecosystem" "$DOC_ZH"
grep -Fq "matlab-scientific-figures#31" "$DOC_ZH"
grep -Fq "gh auth refresh -s read:project -s project" "$DOC_ZH"
grep -Fq "./scripts/check_github_project_board_status.sh --allow-pending" "$DOC_ZH"
grep -Fq "./scripts/check_ecosystem_triage_status.sh" "$DOC_ZH"
grep -Fq "matlab-scientific-figures#9" "$DOC_ZH"
grep -Fq "matlab-scientific-figures#30" "$DOC_ZH"
grep -Fq "matlab-figure-ci#1" "$DOC_ZH"
grep -Fq "matlab-plotting-skill#11" "$DOC_ZH"
grep -Fq "不要在没有公开 URL 或没有核验结果时关闭" "$DOC_ZH"
grep -Fq "不用于承诺任何审核结果" "$DOC_ZH"

if grep -Fq "matlab-plotting-skill#16" "$DOC"; then
  echo "docs/github-project-board.md still references closed issue matlab-plotting-skill#16." >&2
  exit 1
fi

if grep -Fq "matlab-plotting-skill#16" "$DOC_ZH"; then
  echo "docs/github-project-board.zh-CN.md still references closed issue matlab-plotting-skill#16." >&2
  exit 1
fi

echo "GitHub Project board documentation checks passed."
