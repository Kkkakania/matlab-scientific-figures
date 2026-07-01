#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DOC="$ROOT_DIR/docs/github-project-board.md"
DOC_ZH="$ROOT_DIR/docs/github-project-board.zh-CN.md"
HELPER="$ROOT_DIR/scripts/check_github_project_board_status.sh"
TRIAGE_HELPER="$ROOT_DIR/scripts/check_ecosystem_triage_status.sh"
LABEL_HELPER="$ROOT_DIR/scripts/check_ecosystem_issue_labels.sh"

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

if [[ ! -x "$LABEL_HELPER" ]]; then
  echo "Missing executable scripts/check_ecosystem_issue_labels.sh." >&2
  exit 1
fi

grep -Fq "MATLAB Scientific Figure Ecosystem" "$DOC"
grep -Fq "matlab-scientific-figures#31" "$DOC"
grep -Fq "As of 2026-07-01" "$DOC"
grep -Fq "Token scopes: 'gist', 'read:org', 'repo', 'workflow'" "$DOC"
grep -Fq "gh auth refresh -s read:project -s project" "$DOC"
grep -Fq "https://github.com/projects" "$DOC"
grep -Fq "active browser account is" "$DOC"
grep -Fq "browser account can be different" "$DOC"
grep -Fq "MATLAB/Python agent-assisted data-to-figure workflows" "$DOC"
grep -Fq "./scripts/check_github_project_board_status.sh --allow-pending" "$DOC"
grep -Fq "./scripts/check_ecosystem_triage_status.sh" "$DOC"
grep -Fq "./scripts/check_ecosystem_issue_labels.sh" "$DOC"
grep -Fq "Interim labels" "$DOC"
grep -Fq '`documentation`, `ci`' "$DOC"
grep -Fq '`template`, `enhancement`' "$DOC"
grep -Fq "matlab-scientific-figures#30" "$DOC"
grep -Fq "matlab-figure-ci#1" "$DOC"
grep -Fq "Inbox, Triaged, Accepted, In progress, Awaiting feedback, Done" "$DOC"
grep -Fq "gallery, agent, ci, ecosystem-docs" "$DOC"
grep -Fq "none, single-report, reproducible, ci-covered" "$DOC"
grep -Fq "field:\"Evidence level\" != none" "$DOC"
grep -Fq 'Status is "Awaiting feedback"' "$DOC"
grep -Fq "14 days" "$DOC"
grep -Fq "PyPI candidate" "$DOC"

grep -Fq "GitHub Project 看板设置说明" "$DOC_ZH"
grep -Fq "MATLAB Scientific Figure Ecosystem" "$DOC_ZH"
grep -Fq "matlab-scientific-figures#31" "$DOC_ZH"
grep -Fq "截至 2026-07-01" "$DOC_ZH"
grep -Fq "Token scopes: 'gist', 'read:org', 'repo', 'workflow'" "$DOC_ZH"
grep -Fq "gh auth refresh -s read:project -s project" "$DOC_ZH"
grep -Fq "https://github.com/projects" "$DOC_ZH"
grep -Fq "浏览器当前登录账号是" "$DOC_ZH"
grep -Fq 'gh` CLI 账号和浏览器登录账号可能不是同一个' "$DOC_ZH"
grep -Fq "MATLAB/Python agent-assisted data-to-figure workflows" "$DOC_ZH"
grep -Fq "./scripts/check_github_project_board_status.sh --allow-pending" "$DOC_ZH"
grep -Fq "./scripts/check_ecosystem_triage_status.sh" "$DOC_ZH"
grep -Fq "./scripts/check_ecosystem_issue_labels.sh" "$DOC_ZH"
grep -Fq "临时标签" "$DOC_ZH"
grep -Fq '`documentation`, `ci`' "$DOC_ZH"
grep -Fq '`template`, `enhancement`' "$DOC_ZH"
grep -Fq "matlab-scientific-figures#30" "$DOC_ZH"
grep -Fq "matlab-figure-ci#1" "$DOC_ZH"
grep -Fq "不要在没有公开 URL 或没有核验结果时关闭" "$DOC_ZH"
grep -Fq "不用于承诺任何审核结果" "$DOC_ZH"
grep -Fq "Inbox, Triaged, Accepted, In progress, Awaiting feedback, Done" "$DOC_ZH"
grep -Fq "gallery, agent, ci, ecosystem-docs" "$DOC_ZH"
grep -Fq "none, single-report, reproducible, ci-covered" "$DOC_ZH"
grep -Fq "field:\"Evidence level\" != none" "$DOC_ZH"
grep -Fq 'Status is "Awaiting feedback"' "$DOC_ZH"
grep -Fq "超过 14 天" "$DOC_ZH"
grep -Fq "PyPI candidate" "$DOC_ZH"

if grep -Fq "matlab-plotting-skill#16" "$DOC"; then
  echo "docs/github-project-board.md still references closed issue matlab-plotting-skill#16." >&2
  exit 1
fi

if grep -Fq "matlab-plotting-skill#16" "$DOC_ZH"; then
  echo "docs/github-project-board.zh-CN.md still references closed issue matlab-plotting-skill#16." >&2
  exit 1
fi

for stale in \
  "matlab-scientific-figures#9" \
  "matlab-plotting-skill#11" \
  "scientific-diagram-skill#1" \
  "python-plotting-skill#1" \
  "python-plotting-skill#2"; do
  if grep -Fq "$stale" "$DOC" "$DOC_ZH"; then
    echo "GitHub Project board docs still reference closed seed issue $stale." >&2
    exit 1
  fi
done

echo "GitHub Project board documentation checks passed."
