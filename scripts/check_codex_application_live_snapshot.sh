#!/usr/bin/env bash
set -euo pipefail

REPO="${1:-Kkkakania/matlab-scientific-figures}"
EXPECTED_RELEASE="v3.8.0"
EXPECTED_WORKFLOWS=("Quality checks" "Figure quality")

need_cmd() {
  if ! command -v "$1" >/dev/null 2>&1; then
    echo "missing required command: $1" >&2
    exit 2
  fi
}

need_cmd gh
need_cmd python3

json_get() {
  local expr="$1"
  python3 -c 'import json, sys
expr = sys.argv[1]
data = json.load(sys.stdin)
value = data
for part in expr.split("."):
    if not part:
        continue
    if part.endswith("]") and "[" in part:
        name, index = part[:-1].split("[", 1)
        value = value[name][int(index)]
    else:
        value = value.get(part, "") if isinstance(value, dict) else ""
        if value is None:
            value = ""
            break
print(value)' "$expr"
}

latest_run_field() {
  local workflow="$1"
  local field="$2"
  python3 -c 'import json, sys
workflow, field = sys.argv[1], sys.argv[2]
runs = json.load(sys.stdin)
for run in runs:
    if run.get("workflowName") == workflow:
        print(run.get(field) or "")
        break
else:
    print("")' "$workflow" "$field"
}

repo_json="$(gh repo view "$REPO" --json nameWithOwner,visibility,stargazerCount,forkCount,latestRelease,url)"

visibility="$(printf '%s' "$repo_json" | json_get "visibility")"
release_tag="$(printf '%s' "$repo_json" | json_get "latestRelease.tagName")"
stars="$(printf '%s' "$repo_json" | json_get "stargazerCount")"
forks="$(printf '%s' "$repo_json" | json_get "forkCount")"
url="$(printf '%s' "$repo_json" | json_get "url")"

if [[ "$visibility" != "PUBLIC" ]]; then
  echo "repository is not public: $visibility" >&2
  exit 1
fi

if [[ "$release_tag" != "$EXPECTED_RELEASE" ]]; then
  echo "unexpected latest release: $release_tag (expected $EXPECTED_RELEASE)" >&2
  exit 1
fi

if [[ "$stars" =~ ^[0-9]+$ && "$stars" -ge 0 && "$forks" =~ ^[0-9]+$ && "$forks" -ge 0 ]]; then
  :
else
  echo "invalid repo stats: stars=$stars forks=$forks" >&2
  exit 1
fi

runs_json="$(gh run list -R "$REPO" --limit 10 --json workflowName,status,conclusion,headSha,url,createdAt)"

for workflow in "${EXPECTED_WORKFLOWS[@]}"; do
  conclusion="$(printf '%s' "$runs_json" | latest_run_field "$workflow" "conclusion")"
  status="$(printf '%s' "$runs_json" | latest_run_field "$workflow" "status")"
  run_url="$(printf '%s' "$runs_json" | latest_run_field "$workflow" "url")"
  if [[ "$status" != "completed" || "$conclusion" != "success" ]]; then
    echo "latest $workflow run is not green: status=$status conclusion=$conclusion" >&2
    exit 1
  fi
  echo "OK $workflow: $run_url"
done

cat <<EOF
Codex application live snapshot:
- Repository: $url
- Visibility: $visibility
- Latest release: $release_tag
- Stars: $stars
- Forks: $forks
- CI: latest Quality checks and Figure quality runs are successful
EOF
