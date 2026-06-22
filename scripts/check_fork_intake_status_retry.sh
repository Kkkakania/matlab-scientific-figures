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
  echo 'Get "https://api.github.com/repos/example/forks": EOF' >&2
  exit 1
fi

case "$*" in
  api\ repos/Kkkakania/*/forks*)
    echo "Example/fork"
    ;;
  api\ repos/Example/fork\ --jq\ .default_branch)
    echo "main"
    ;;
  api\ repos/Example/fork/compare/*)
    echo "status=identical ahead=0 behind=0 fork=Example/fork branch=main"
    ;;
  *)
    echo "unexpected gh call: $*" >&2
    exit 2
    ;;
esac
SH
chmod +x "$TMP_DIR/gh"

echo 0 >"$TMP_DIR/state"
out="$TMP_DIR/fork-intake-retry.out"
TMP_GH_STATE="$TMP_DIR/state" GH_RETRY_DELAY_SECONDS=0 PATH="$TMP_DIR:$PATH" \
  "$ROOT_DIR/scripts/check_fork_intake_status.sh" >"$out"

grep -q "== matlab-scientific-figures visible fork comparisons ==" "$out"
grep -q "status=identical ahead=0 behind=0 fork=Example/fork branch=main" "$out"

echo "Fork intake retry check passed."
