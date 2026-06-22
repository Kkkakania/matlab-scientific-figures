#!/usr/bin/env bash
set -euo pipefail

REPO="${1:-Kkkakania/matlab-scientific-figures}"
EXPECTED_RELEASE="v3.8.0"
EXPECTED_WORKFLOWS=("Quality checks" "Figure quality")
COMPANION_REPOS=(
  "Kkkakania/scientific-diagram-skill:Quality"
)

need_cmd() {
  if ! command -v "$1" >/dev/null 2>&1; then
    echo "missing required command: $1" >&2
    exit 2
  fi
}

need_cmd gh
need_cmd python3

gh_retry() {
  local attempt=1
  local max_attempts="${GH_RETRY_ATTEMPTS:-3}"
  local delay="${GH_RETRY_DELAY_SECONDS:-1}"
  local output status

  while true; do
    if output="$(gh "$@" 2>&1)"; then
      printf '%s\n' "$output"
      return 0
    fi
    status=$?
    if [[ "$output" != *"EOF"* && "$output" != *"HTTP 5"* && "$output" != *"timeout"* ]] || [[ "$attempt" -ge "$max_attempts" ]]; then
      printf '%s\n' "$output" >&2
      return "$status"
    fi
    sleep "$delay"
    attempt=$((attempt + 1))
  done
}

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

repo_json="$(gh_retry repo view "$REPO" --json nameWithOwner,visibility,stargazerCount,forkCount,latestRelease,url)"

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

runs_json="$(gh_retry run list -R "$REPO" --limit 10 --json databaseId,workflowName,status,conclusion,headSha,url,createdAt)"

for workflow in "${EXPECTED_WORKFLOWS[@]}"; do
  conclusion="$(printf '%s' "$runs_json" | latest_run_field "$workflow" "conclusion")"
  status="$(printf '%s' "$runs_json" | latest_run_field "$workflow" "status")"
  run_url="$(printf '%s' "$runs_json" | latest_run_field "$workflow" "url")"
  run_id="$(printf '%s' "$runs_json" | latest_run_field "$workflow" "databaseId")"
  if [[ "$status" != "completed" || "$conclusion" != "success" ]]; then
    echo "latest $workflow run is not green: status=$status conclusion=$conclusion" >&2
    exit 1
  fi
  annotation_count="$(
    gh_retry run view "$run_id" -R "$REPO" --json jobs --jq '[.jobs[].annotations[]?] | length'
  )"
  if [[ "$annotation_count" != "0" ]]; then
    echo "latest $workflow run has $annotation_count GitHub annotation(s): $run_url" >&2
    exit 1
  fi
  echo "OK $workflow: $run_url (no annotations)"
done

for companion in "${COMPANION_REPOS[@]}"; do
  companion_repo="${companion%%:*}"
  companion_workflow="${companion#*:}"
  companion_json="$(gh_retry repo view "$companion_repo" --json visibility,url)"
  companion_visibility="$(printf '%s' "$companion_json" | json_get "visibility")"
  companion_url="$(printf '%s' "$companion_json" | json_get "url")"
  if [[ "$companion_visibility" != "PUBLIC" ]]; then
    echo "companion repository is not public: $companion_repo visibility=$companion_visibility" >&2
    exit 1
  fi

  companion_runs="$(gh_retry run list -R "$companion_repo" --limit 10 --json databaseId,workflowName,status,conclusion,headSha,url,createdAt)"
  companion_status="$(printf '%s' "$companion_runs" | latest_run_field "$companion_workflow" "status")"
  companion_conclusion="$(printf '%s' "$companion_runs" | latest_run_field "$companion_workflow" "conclusion")"
  companion_run_url="$(printf '%s' "$companion_runs" | latest_run_field "$companion_workflow" "url")"
  companion_run_id="$(printf '%s' "$companion_runs" | latest_run_field "$companion_workflow" "databaseId")"

  if [[ "$companion_status" != "completed" || "$companion_conclusion" != "success" ]]; then
    echo "latest $companion_repo $companion_workflow run is not green: status=$companion_status conclusion=$companion_conclusion" >&2
    exit 1
  fi

  companion_annotation_count="$(
    gh_retry run view "$companion_run_id" -R "$companion_repo" --json jobs --jq '[.jobs[].annotations[]?] | length'
  )"
  if [[ "$companion_annotation_count" != "0" ]]; then
    echo "latest $companion_repo $companion_workflow run has $companion_annotation_count GitHub annotation(s): $companion_run_url" >&2
    exit 1
  fi
  echo "OK companion $companion_repo $companion_workflow: $companion_run_url (no annotations, $companion_url)"
done

cat <<EOF
Codex application live snapshot:
- Repository: $url
- Visibility: $visibility
- Latest release: $release_tag
- Stars: $stars
- Forks: $forks
- CI: latest Quality checks and Figure quality runs are successful and annotation-free
- Companion CI: scientific-diagram-skill latest Quality run is successful and annotation-free
EOF
