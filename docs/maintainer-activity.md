# Maintainer Activity

Snapshot date: 2026-09-16

This page records factual maintenance activity for the MATLAB plotting
ecosystem. It is a reviewer aid, not an adoption claim.

## Own Repositories

| Repository | Current maintenance evidence |
|---|---|
| [`matlab-scientific-figures`](https://github.com/Kkkakania/matlab-scientific-figures) | 31 clean-room gallery examples, three electrical domain examples, manifest-backed discovery and reference-sync tools, release checks, and figure-quality dogfooding |
| [`matlab-figure-ci`](https://github.com/Kkkakania/matlab-figure-ci) | CLI/package tests, release-preflight checks, package artifact workflow, downstream dogfooding report, and release artifact version validation |
| [`matlab-plotting-skill`](https://github.com/Kkkakania/matlab-plotting-skill) | first-render walkthrough, scheme readiness matrix, privacy/provenance checks, and plotting data-extension validation before MATLAB startup |
| [`scientific-diagram-skill`](https://github.com/Kkkakania/scientific-diagram-skill) | public diagram Skill, checked `.drawio` and SVG example, manifest validation, provenance note, quality workflow, and contribution/security entrypoints |
| [`python-plotting-skill`](https://github.com/Kkkakania/python-plotting-skill) | early public Python Skill, synthetic Matplotlib gallery, malformed-manifest handling, repository quality checks, and a first-use feedback surface |

## Fork And Pull Request Intake

As of the snapshot date, the tracked repositories have five recent merged
maintenance pull requests in the snapshot below. Recent public forks were
checked against `main`; the visible fork branches for the MATLAB repositories
were behind the upstream repositories and did not contain ahead commits to
review or merge. Treat forks, issue counts, and own-repository pull requests as
maintenance context, not as adoption metrics or pending contribution evidence.

Live fork intake can be repeated with:

```bash
./scripts/check_fork_intake_status.sh
```

Latest visible-fork snapshot:

| Repository | Visible forks checked | Ahead commits to review |
|---|---:|---:|
| `matlab-scientific-figures` | 4 | 0 |
| `matlab-figure-ci` | 4 | 0 |
| `matlab-plotting-skill` | 4 | 0 |
| `scientific-diagram-skill` | 0 | 0 |
| `python-plotting-skill` | 0 | 0 |

The latest visible forks included `Fantastic-wil2`, `Fantastic-wil`,
`Williamkakania`, and `Wppypepyyy` forks depending on repository. All checked
default branches were behind upstream `main`.

Recently merged own-repository pull request snapshot:

| Repository | Pull request | Status at snapshot | Scope |
|---|---|---|---|
| `matlab-scientific-figures` | [`#72`](https://github.com/Kkkakania/matlab-scientific-figures/pull/72) | Merged on 2026-08-27 | Check data files before MATLAB startup |
| `matlab-figure-ci` | [`#77`](https://github.com/Kkkakania/matlab-figure-ci/pull/77) | Merged on 2026-09-11 | Validate release artifact versions |
| `matlab-plotting-skill` | [`#49`](https://github.com/Kkkakania/matlab-plotting-skill/pull/49) | Merged on 2026-08-27 | Validate plotting data extensions before MATLAB startup |
| `scientific-diagram-skill` | [`#23`](https://github.com/Kkkakania/scientific-diagram-skill/pull/23) | Merged on 2026-09-11 | Validate diagram manifest structure |
| `python-plotting-skill` | [`#38`](https://github.com/Kkkakania/python-plotting-skill/pull/38) | Merged on 2026-09-11 | Handle malformed gallery manifests without a traceback |

## External Pull Requests

| Project | Pull request | Status at snapshot | Scope |
|---|---|---|---|
| `bokeh/bokeh` | [`#15216`](https://github.com/bokeh/bokeh/pull/15216) | Approved and merged on 2026-09-11 | Prune stale selections across data replacement, streaming, and patching, with synchronization and linked-selection regressions |
| `pyvista/pyvista` | [`#8845`](https://github.com/pyvista/pyvista/pull/8845) | Approved and merged on 2026-08-05 | Register the top-level `pyvista` documentation target with regression coverage |
| `xarray-contrib/cf-xarray` | [`#659`](https://github.com/xarray-contrib/cf-xarray/pull/659) | Merged on 2026-07-29 | Fix custom criteria membership checks |
| `xarray-contrib/cf-xarray` | [`#661`](https://github.com/xarray-contrib/cf-xarray/pull/661) | Merged on 2026-07-29 | Support dictionary-style CF indexing |
| `arviz-devs/arviz-plots` | [`#542`](https://github.com/arviz-devs/arviz-plots/pull/542) | Open, clean | Fix rug rendering for Bokeh and Plotly backends |
| `pyqtgraph/pyqtgraph` | [`#3507`](https://github.com/pyqtgraph/pyqtgraph/pull/3507) | Open, clean | Fix FFT autorange with automatic downsampling |
| `pyqtgraph/pyqtgraph` | [`#3538`](https://github.com/pyqtgraph/pyqtgraph/pull/3538) | Open, clean | Preserve ImageView histogram range across frames |

## Review Policy

- Prefer low-risk fixes that are easy for upstream maintainers to review.
- Do not ask for status updates unless a maintainer requests follow-up or a
  real conflict appears.
- Keep external contributions scoped to the upstream project's style and
  current maintenance state.
- Avoid feature PRs that depend on private data, copied source material, or
  unverified assumptions about a project.

## Claim Boundary

These records show maintenance activity and public review surfaces. They do not
show broad adoption, high download volume, guaranteed program eligibility, or
approval by any external benefit program.
