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
  echo 'failed to get run: Get "https://api.github.com/example": EOF' >&2
  exit 1
fi

case "$*" in
  repo\ view*)
    cat <<'JSON'
{"nameWithOwner":"Kkkakania/matlab-scientific-figures","visibility":"PUBLIC","stargazerCount":6,"forkCount":4,"latestRelease":{"tagName":"v3.8.0"},"url":"https://github.com/Kkkakania/matlab-scientific-figures"}
JSON
    ;;
  run\ list*)
    cat <<'JSON'
[{"databaseId":101,"workflowName":"Quality checks","status":"completed","conclusion":"success","url":"https://example.test/quality"},{"databaseId":102,"workflowName":"Figure quality","status":"completed","conclusion":"success","url":"https://example.test/figure"}]
JSON
    ;;
  run\ view*)
    echo 0
    ;;
  *)
    echo "unexpected gh call: $*" >&2
    exit 2
    ;;
esac
SH
chmod +x "$TMP_DIR/gh"

echo 0 >"$TMP_DIR/state"
out="$TMP_DIR/live-snapshot-retry.out"
TMP_GH_STATE="$TMP_DIR/state" GH_RETRY_DELAY_SECONDS=0 PATH="$TMP_DIR:$PATH" \
  "$ROOT_DIR/scripts/check_codex_application_live_snapshot.sh" >"$out"

grep -q "Codex application live snapshot:" "$out"
grep -q "OK Quality checks" "$out"
grep -q "OK Figure quality" "$out"

echo "Codex application live snapshot retry check passed."
