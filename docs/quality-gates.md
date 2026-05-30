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

## Repository Checks

| Gate | Command | What It Catches |
|---|---|---|
| Gallery files | `./scripts/check_gallery_outputs.sh` | Missing PNG or SVG outputs for registered examples |
| Metadata consistency | `./scripts/check_gallery_consistency.sh` | Drift between registry, examples docs, gallery files, and CI config |
| Forbidden files | `./scripts/check_forbidden_files.sh` | `.p`, `.fig`, `.mat`, Office files, PDFs, archives, raw/OCR/tmp folders |
| Privacy scan | `./scripts/check_privacy.sh` | Emails, local paths, personal identifiers, and platform traces |
| Provenance scan | `./scripts/check_provenance.sh` | Third-party author, license, platform, or source-pack traces |
| CLI discovery | `./scripts/check_cli_commands.sh` | Broken `render_all.sh list` or `render_all.sh search` commands |

## MATLAB Checks

These run when MATLAB is available:

```bash
MATLAB_BIN=/Applications/MATLAB_R2025a.app/bin/matlab ./scripts/validate_gallery.sh
MATLAB_BIN=/Applications/MATLAB_R2025a.app/bin/matlab ./scripts/check_cli_commands.sh
```

The MATLAB unit tests cover shared helpers, deterministic data, SVG metadata
sanitizing, figure validation, registry integrity, and selected rendering.

## GitHub Actions

`quality.yml` runs the repository checks on every push and pull request.
`figure-quality.yml` runs `matlab-figure-ci` against the committed gallery.

MATLAB itself is not assumed to be present in GitHub Actions. Maintainers should
run the MATLAB-enforced gate locally before a release.

## When A Gate Fails

Fix the source of the failure instead of weakening the scan. If a false positive
is unavoidable, document the reason in the pull request and keep the exception
as narrow as possible.
