# Quality Gates

This repository uses small checks instead of one large opaque release script.
Run the combined gate before tagging:

```bash
./scripts/check_release_ready.sh
```

For a fast non-MATLAB pass while editing docs or metadata:

```bash
./scripts/check_static_quality.sh
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
| Metadata consistency | `./scripts/check_gallery_consistency.sh` | Drift between registry, examples docs, gallery reference, gallery files, and CI config |
| Version metadata | `./scripts/check_version_consistency.sh` | README, ROADMAP, version plan, maintainer dashboard, release cadence, and changelog release mismatch |
| Roadmap status | `./scripts/check_roadmap_status.sh` | Stale roadmap language that makes released milestones look like old planned work |
| Maintainer activity | `./scripts/check_maintainer_activity.sh` | Unsupported adoption or approval claims in the activity snapshot |
| Citation metadata | `./scripts/check_citation.sh` | Missing or stale `CITATION.cff` metadata |
| Documentation links | `./scripts/check_docs_links.sh` | Broken local Markdown links and gallery image references |
| API reference | `./scripts/check_api_reference.sh` | Public MATLAB functions missing from the API reference |
| Template manifest schema | `./scripts/check_template_manifest_schema.sh` | JSON field, uniqueness, and referenced-file drift |
| Template reference table | `./scripts/check_template_reference_table.sh` | Drift between manifest metadata and the template reference table |
| Tag reference | `./scripts/check_tag_reference.sh` | Drift between manifest tags and tag-reference counts/examples |
| Tag gallery | `./scripts/check_tag_gallery.sh` | Stale generated tag-gallery documentation |
| Examples README table | `./scripts/check_examples_readme_table.sh` | Drift between manifest renderers and the examples README |
| MATLAB help text | `./scripts/check_matlab_help.sh` | Public MATLAB functions missing a one-line help summary |
| README gallery | `./scripts/check_readme_gallery.sh` | README gallery count or first-screen preview drift |
| Toolbox independence | `./scripts/check_toolbox_independence.sh` | Accidental toolbox-only calls in public MATLAB examples |
| Compatibility docs | `./scripts/check_compatibility_docs.sh` | Missing notes for version-sensitive MATLAB APIs |
| Color accessibility audit | `./scripts/check_color_accessibility_audit.sh` | Missing color-risk review rows for public templates |
| CLI script static checks | `./scripts/check_cli_script_static.sh` | Shell helper drift for format selection or documented CLI examples |
| render_all argument checks | `./scripts/check_render_all_args.sh` | Broken non-MATLAB validation for export formats and output paths |
| Timeout helper | `./scripts/check_timeout_helper.sh` | Timeout wrapper regressions before MATLAB checks rely on it |
| Forbidden files | `./scripts/check_forbidden_files.sh` | `.p`, `.fig`, `.mat`, Office files, PDFs, archives, raw/OCR/tmp folders |
| Privacy scan | `./scripts/check_privacy.sh` | Emails, local paths, personal identifiers, and platform traces |
| Provenance scan | `./scripts/check_provenance.sh` | Third-party author, license, platform, or source-pack traces |
| Local resource intake | `./scripts/check_local_resource_intake.sh` | Drift in private-prototype boundaries, backlog intake language, and clean-room promotion rules |
| Application evidence packet | `./scripts/check_application_evidence_packet.sh` | Missing or overstated public evidence for application/reviewer packets |
| Generated asset placement | `mfigci scan` | Rendered images or PDFs that accidentally appear beside source/template files |
| CLI discovery | `./scripts/check_cli_commands.sh` | Broken `render_all.sh list`, `tags`, `search`, `tag`, or `match` commands |
| First-use smoke test | `./scripts/check_first_use.sh` | Broken list/info/selected-render workflow from a fresh clone |
| Template manifest | `./scripts/check_template_manifest.sh` | Stale `docs/template-manifest.json` after registry changes |

## Badge Scope

The README badges are intentionally narrow CI signals. They should not be read
as claims that every MATLAB renderer was executed on GitHub-hosted runners.

| Badge | Workflow | Runs MATLAB? | What Green Means |
|---|---|---:|---|
| `Quality checks` | `.github/workflows/quality.yml` | No | The committed repository passes static shell checks for gallery-file presence, metadata consistency, documentation links, manifest/schema drift, version/citation metadata, compatibility notes, color-audit coverage, forbidden files, privacy traces, and provenance traces. |
| `Figure quality` | `.github/workflows/figure-quality.yml` | No | `matlab-figure-ci` can scan the committed repository and verify the configured committed gallery outputs without policy errors. |

`figure-quality.yml` installs `matlab-figure-ci` v2.5.0 from its GitHub release
tag. Keep that pinned tag aligned with README and the maintainer dashboard when
the companion checker intentionally moves to a newer public release.

These badges do not prove that committed PNG/SVG files were regenerated from
the current MATLAB source. Maintainers should run the MATLAB-enabled local gate
before a release or before trusting regenerated gallery output:

```bash
MATLAB_BIN=/Applications/MATLAB_R2025a.app/bin/matlab REQUIRE_MATLAB=1 ./scripts/check_release_ready.sh
```

## MATLAB Checks

These run when MATLAB is available:

```bash
MATLAB_BIN=/Applications/MATLAB_R2025a.app/bin/matlab ./scripts/validate_gallery.sh
MATLAB_BIN=/Applications/MATLAB_R2025a.app/bin/matlab ./scripts/check_cli_commands.sh
MATLAB_BIN=/Applications/MATLAB_R2025a.app/bin/matlab ./scripts/check_first_use.sh
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
