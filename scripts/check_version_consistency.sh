#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

extract_first() {
  local pattern="$1"
  local file="$2"
  sed -nE "$pattern" "$ROOT_DIR/$file" | head -n 1
}

readme_version="$(extract_first 's/^Current public release: `(v[0-9]+\.[0-9]+\.[0-9]+)`\.$/\1/p' README.md)"
roadmap_version="$(extract_first 's/^- Current public release: `(v[0-9]+\.[0-9]+\.[0-9]+)`\.$/\1/p' ROADMAP.md)"
version_plan_version="$(extract_first 's/^- `(v[0-9]+\.[0-9]+\.[0-9]+)` is the current release\.$/\1/p' docs/version-plan.md)"
dashboard_version="$(extract_first 's/^- Current released line: `(v[0-9]+\.[0-9]+\.[0-9]+)`\.$/\1/p' docs/maintainer-dashboard.md)"
changelog_version="$(extract_first 's/^## (v[0-9]+\.[0-9]+\.[0-9]+) - [0-9]{4}-[0-9]{2}-[0-9]{2}$/\1/p' CHANGELOG.md)"
cadence_version="$(extract_first 's/^- Keep `(v[0-9]+\.[0-9]+\.[0-9]+)` as the current public release until a user-visible reason$/\1/p' docs/release-cadence.md)"

missing=0
for name in readme_version roadmap_version version_plan_version dashboard_version changelog_version cadence_version; do
  if [[ -z "${!name}" ]]; then
    echo "Could not find $name in release metadata files." >&2
    missing=1
  fi
done

if [[ "$missing" -ne 0 ]]; then
  exit 1
fi

if [[ "$readme_version" != "$roadmap_version" || \
      "$readme_version" != "$version_plan_version" || \
      "$readme_version" != "$dashboard_version" || \
      "$readme_version" != "$changelog_version" || \
      "$readme_version" != "$cadence_version" ]]; then
  cat >&2 <<EOF
Version metadata mismatch:
  README.md:         $readme_version
  ROADMAP.md:        $roadmap_version
  docs/version-plan: $version_plan_version
  maintainer dash:   $dashboard_version
  release cadence:   $cadence_version
  CHANGELOG.md:      $changelog_version
EOF
  exit 1
fi

echo "Version metadata is consistent: $readme_version"
