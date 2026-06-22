#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

cat >"$TMP_DIR/gh" <<'SH'
#!/usr/bin/env bash
set -euo pipefail

state="${TMP_GH_STATE:?}"
count="$(cat "$state")"
if [[ "$count" == "0" ]]; then
  echo 1 >"$state"
  echo 'Post "https://api.github.com/graphql": EOF' >&2
  exit 1
fi

case "$*" in
  issue\ view*)
    printf '%s\n' documentation ci template enhancement first-use "help wanted" "good first issue" question testing feedback
    ;;
  *)
    echo "unexpected gh call: $*" >&2
    exit 2
    ;;
esac
SH
chmod +x "$TMP_DIR/gh"

echo 0 >"$TMP_DIR/state"
out="$TMP_DIR/issue-labels-retry.out"
TMP_GH_STATE="$TMP_DIR/state" GH_RETRY_DELAY_SECONDS=0 PATH="$TMP_DIR:$PATH" \
  "$ROOT_DIR/scripts/check_ecosystem_issue_labels.sh" >"$out"

grep -q "Ecosystem issue label checks passed." "$out"
grep -q "OK label: documentation" "$out"
grep -q "OK label: good first issue" "$out"

echo "Ecosystem issue label retry check passed."
