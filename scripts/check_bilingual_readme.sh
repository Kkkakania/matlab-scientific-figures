#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
README="$ROOT_DIR/README.md"
README_ZH="$ROOT_DIR/README.zh-CN.md"

if [[ ! -f "$README_ZH" ]]; then
  echo "Missing README.zh-CN.md." >&2
  exit 1
fi

grep -Fq "[中文](README.zh-CN.md)" "$README"
grep -Fq "[English](README.md)" "$README_ZH"
grep -Fq "clean-room" "$README_ZH"
grep -Fq "CSV/Excel" "$README_ZH"
grep -Fq "不收录私人素材包" "$README_ZH"
grep -Fq "GitHub Project 看板设置说明" "$README_ZH"
grep -Fq "matlab-scientific-figures#31" "$README_ZH"
grep -Fq "./scripts/check_ecosystem_triage_status.sh" "$README_ZH"
grep -Fq "Current public release" "$README"
grep -Fq "当前公开版本" "$README_ZH"

echo "Bilingual README checks passed."
