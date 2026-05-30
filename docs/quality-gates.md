# Quality Gates

This repository uses small checks instead of one large opaque release script.
Run the combined gate before tagging:

```bash
./scripts/check_release_ready.sh
```

Run it with MATLAB enforced when MATLAB is installed:

```bash
MATLAB_BIN=/Applications/MATLAB_R2025a.app/bin/matlab REQUIRE_MATLAB=1 ./scripts/check_release_ready.sh
```

MATLAB invocations use a timeout guard so failed local runs do not linger in the
background. Override the default 600-second limit when needed:

```bash
SFT_MATLAB_TIMEOUT_SECONDS=900 MATLAB_BIN=/Applications/MATLAB_R2025a.app/bin/matlab REQUIRE_MATLAB=1 ./scripts/check_release_ready.sh
```

## Repository Checks

| Gate | Command | What It Catches |
|---|---|---|
| Gallery files | `./scripts/check_gallery_outputs.sh` | Missing PNG or SVG outputs for registered examples |
| Metadata consistency | `./scripts/check_gallery_consistency.sh` | Drift between registry, examples docs, gallery files, and CI config |
| Version metadata | `./scripts/check_version_consistency.sh` | README, ROADMAP, version plan, maintainer dashboard, release cadence, and changelog release mismatch |
| Documentation links | `./scripts/check_docs_links.sh` | Broken local Markdown links and gallery image references |
| README gallery | `./scripts/check_readme_gallery.sh` | README gallery count or first-screen preview drift |
| Timeout helper | `./scripts/check_timeout_helper.sh` | Timeout wrapper regressions before MATLAB checks rely on it |
| Forbidden files | `./scripts/check_forbidden_files.sh` | `.p`, `.fig`, `.mat`, Office files, PDFs, archives, raw/OCR/tmp folders |
| Privacy scan | `./scripts/check_privacy.sh` | Emails, local paths, personal identifiers, and platform traces |
| Provenance scan | `./scripts/check_provenance.sh` | Third-party author, license, platform, or source-pack traces |
| CLI discovery | `./scripts/check_cli_commands.sh` | Broken `render_all.sh list`, `tags`, `search`, `tag`, or `match` commands |
| Template manifest | `./scripts/check_template_manifest.sh` | Stale `docs/template-manifest.json` after registry changes |

## MATLAB Checks

These run when MATLAB is available:

```bash
MATLAB_BIN=/Applications/MATLAB_R2025a.app/bin/matlab ./scripts/validate_gallery.sh
MATLAB_BIN=/Applications/MATLAB_R2025a.app/bin/matlab ./scripts/check_cli_commands.sh
```

The MATLAB unit tests cover shared helpers, deterministic data, SVG metadata
sanitizing, figure validation, registry integrity, selected rendering, and
machine-readable manifest generation.

## GitHub Actions

`quality.yml` runs the repository checks on every push and pull request.
`figure-quality.yml` runs `matlab-figure-ci` against the committed gallery.

MATLAB itself is not assumed to be present in GitHub Actions. Maintainers should
run the MATLAB-enforced gate locally before a release.

## When A Gate Fails

Fix the source of the failure instead of weakening the scan. If a false positive
is unavoidable, document the reason in the pull request and keep the exception
as narrow as possible.
