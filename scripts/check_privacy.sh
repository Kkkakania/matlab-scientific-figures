#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PATTERN='([A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}|/Users/|WeChat|wechat|微信|公众号|知乎|小红书|CSDN|B站|哔哩|手机号|身份证|银行卡|家庭住址|三峡大学|China Three Gorges)'

found=0
while IFS= read -r file; do
  case "$file" in
    */.git/*|*/scripts/check_privacy.sh|*/scripts/check_provenance.sh) continue ;;
  esac

  if grep -nE "$PATTERN" "$file" >/tmp/sft_privacy_match.$$ 2>/dev/null; then
    echo "Privacy-sensitive pattern found in ${file#$ROOT_DIR/}:" >&2
    cat /tmp/sft_privacy_match.$$ >&2
    found=1
  fi
done < <(find "$ROOT_DIR" -type f \( -name '*.m' -o -name '*.md' -o -name '*.sh' -o -name 'README' -o -name 'LICENSE' \))

rm -f /tmp/sft_privacy_match.$$
if [[ "$found" -ne 0 ]]; then
  exit 1
fi

echo "Privacy check passed."
