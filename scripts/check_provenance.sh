#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PATTERN='([Aa]uthor:|GNU General Public License|[Gg][Pp][Ll]|MatPlotLib|MathWorks|[Ss]tack [Oo]verflow|[Ss]tack[Ee]xchange|[Gg]it[Hh]ub [Gg]ist|gist\.github\.com|[Kk]aggle|Columbia|Potsdam|UBC|[Aa][Kk][Uu][Nn]|zhuanlan|bilibili|Nature论文|Science论文|珞研|阿昆|公众号|微信|知乎|小红书|[Cc][Ss][Dd][Nn]|/Users/wi/Documents/Study)'
MATCHES_FILE="$(mktemp)"
trap 'rm -f "$MATCHES_FILE"' EXIT

found=0
while IFS= read -r file; do
  case "$file" in
    */.git/*|*/LICENSE|*/scripts/check_provenance.sh|*/scripts/check_privacy.sh) continue ;;
  esac

  if grep -nE "$PATTERN" "$file" 2>/dev/null \
      | grep -v 'data:image/' >"$MATCHES_FILE"; then
    echo "Provenance-risk pattern found in ${file#$ROOT_DIR/}:" >&2
    cat "$MATCHES_FILE" >&2
    found=1
  fi
done < <(find "$ROOT_DIR" -type f \( \
  -name '*.m' -o -name '*.md' -o -name '*.sh' -o -name '*.svg' -o \
  -name '*.yml' -o -name '*.yaml' -o -name '*.json' -o -name 'README' \))

if [[ "$found" -ne 0 ]]; then
  exit 1
fi

echo "Provenance check passed."
