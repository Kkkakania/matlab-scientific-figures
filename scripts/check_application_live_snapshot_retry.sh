#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

cat >"$TMP_DIR/gh" <<'SH'
#!/usr/bin/env bash
set -euo pipefail

state="${TMP_GH_STATE:?}"
case "${TMP_GH_FAILURE_MODE:-}" in
  nonretryable)
    echo "authentication failed" >&2
    exit 7
    ;;
  persistent-eof)
    echo 'failed to get run: Get "https://api.github.com/example": EOF' >&2
    exit 8
    ;;
esac

count="$(cat "$state")"
if [[ "$count" == "0" ]]; then
  echo 1 >"$state"
  echo 'failed to get run: Get "https://api.github.com/example": EOF' >&2
  exit 1
fi

case "$*" in
  repo\ view*Kkkakania/matlab-scientific-figures*)
    cat <<'JSON'
{"nameWithOwner":"Kkkakania/matlab-scientific-figures","visibility":"PUBLIC","stargazerCount":6,"forkCount":4,"latestRelease":{"tagName":"v3.8.0"},"url":"https://github.com/Kkkakania/matlab-scientific-figures"}
JSON
    ;;
  repo\ view*)
    cat <<'JSON'
{"visibility":"PUBLIC","url":"https://github.com/Kkkakania/companion"}
JSON
    ;;
  run\ list*Kkkakania/matlab-scientific-figures*)
    cat <<'JSON'
[{"databaseId":101,"workflowName":"Quality checks","status":"completed","conclusion":"success","url":"https://example.test/quality"},{"databaseId":102,"workflowName":"Figure quality","status":"completed","conclusion":"success","url":"https://example.test/figure"}]
JSON
    ;;
  run\ list*Kkkakania/matlab-figure-ci*)
    cat <<'JSON'
[{"databaseId":201,"workflowName":"CI","status":"completed","conclusion":"success","url":"https://example.test/mfigci-ci"},{"databaseId":202,"workflowName":"Package","status":"completed","conclusion":"success","url":"https://example.test/mfigci-package"}]
JSON
    ;;
  run\ list*Kkkakania/matlab-plotting-skill*)
    cat <<'JSON'
[{"databaseId":301,"workflowName":"Quality","status":"completed","conclusion":"success","url":"https://example.test/matlab-skill-quality"}]
JSON
    ;;
  run\ list*Kkkakania/scientific-diagram-skill*)
    cat <<'JSON'
[{"databaseId":401,"workflowName":"Quality","status":"completed","conclusion":"success","url":"https://example.test/diagram-quality"}]
JSON
    ;;
  run\ list*Kkkakania/python-plotting-skill*)
    cat <<'JSON'
[{"databaseId":501,"workflowName":"Quality","status":"completed","conclusion":"success","url":"https://example.test/python-skill-quality"}]
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
  "$ROOT_DIR/scripts/check_application_live_snapshot.sh" >"$out"

grep -q "Application live snapshot:" "$out"
grep -q "OK Kkkakania/matlab-scientific-figures Quality checks" "$out"
grep -q "OK Kkkakania/matlab-scientific-figures Figure quality" "$out"
grep -q "OK Kkkakania/matlab-figure-ci CI" "$out"
grep -q "OK Kkkakania/matlab-figure-ci Package" "$out"
grep -q "OK Kkkakania/matlab-plotting-skill Quality" "$out"
grep -q "OK Kkkakania/scientific-diagram-skill Quality" "$out"
grep -q "OK Kkkakania/python-plotting-skill Quality" "$out"
grep -q "Companion CI: matlab-figure-ci CI and Package" "$out"

failure_out="$TMP_DIR/nonretryable.out"
if TMP_GH_STATE="$TMP_DIR/state" TMP_GH_FAILURE_MODE=nonretryable \
  GH_RETRY_DELAY_SECONDS=0 PATH="$TMP_DIR:$PATH" \
  "$ROOT_DIR/scripts/check_application_live_snapshot.sh" >"$failure_out" 2>&1; then
  echo "live snapshot unexpectedly accepted a non-retryable gh failure" >&2
  exit 1
fi
grep -q "authentication failed" "$failure_out"

failure_out="$TMP_DIR/persistent-eof.out"
if TMP_GH_STATE="$TMP_DIR/state" TMP_GH_FAILURE_MODE=persistent-eof \
  GH_RETRY_ATTEMPTS=2 GH_RETRY_DELAY_SECONDS=0 PATH="$TMP_DIR:$PATH" \
  "$ROOT_DIR/scripts/check_application_live_snapshot.sh" >"$failure_out" 2>&1; then
  echo "live snapshot unexpectedly accepted retry exhaustion" >&2
  exit 1
fi
grep -q "EOF" "$failure_out"

echo "Application live snapshot retry check passed."
