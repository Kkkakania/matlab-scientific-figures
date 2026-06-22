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
  issue\ list*)
    echo '#1 Example issue [labels: documentation] updated=2026-06-22T00:00:00Z'
    ;;
  pr\ list*)
    echo '#2 Example PR [head: docs/example] updated=2026-06-22T00:00:00Z'
    ;;
  *)
    echo "unexpected gh call: $*" >&2
    exit 2
    ;;
esac
SH
chmod +x "$TMP_DIR/gh"

echo 0 >"$TMP_DIR/state"
out="$TMP_DIR/triage-status-retry.out"
TMP_GH_STATE="$TMP_DIR/state" GH_RETRY_DELAY_SECONDS=0 PATH="$TMP_DIR:$PATH" \
  "$ROOT_DIR/scripts/check_ecosystem_triage_status.sh" >"$out"

grep -q "== Kkkakania/matlab-scientific-figures open issues ==" "$out"
grep -q "Example issue" "$out"
grep -q "Example PR" "$out"

echo "Ecosystem triage status retry check passed."
