#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PATTERN='(Author:|GNU General Public License|GPL|MatPlotLib|MathWorks|Columbia|Potsdam|UBC|Akun|zhuanlan|bilibili|Nature论文|Science论文|珞研|阿昆|公众号|微信|知乎|小红书|CSDN|/Users/wi/Documents/Study)'

found=0
while IFS= read -r file; do
  case "$file" in
    */.git/*|*/LICENSE|*/scripts/check_provenance.sh|*/scripts/check_privacy.sh) continue ;;
  esac

  if grep -nE "$PATTERN" "$file" 2>/dev/null \
      | grep -v 'data:image/' >/tmp/sft_provenance_match.$$; then
    echo "Provenance-risk pattern found in ${file#$ROOT_DIR/}:" >&2
    cat /tmp/sft_provenance_match.$$ >&2
    found=1
  fi
done < <(find "$ROOT_DIR" -type f \( \
  -name '*.m' -o -name '*.md' -o -name '*.sh' -o -name '*.svg' -o \
  -name '*.yml' -o -name '*.yaml' -o -name '*.json' -o -name 'README' \))

rm -f /tmp/sft_provenance_match.$$
if [[ "$found" -ne 0 ]]; then
  exit 1
fi

echo "Provenance check passed."
