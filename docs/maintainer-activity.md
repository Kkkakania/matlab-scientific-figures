# Maintainer Activity

Snapshot date: 2026-06-22

This page records factual maintenance activity for the MATLAB plotting
ecosystem. It is a reviewer aid, not an adoption claim.

## Own Repositories

| Repository | Current maintenance evidence |
|---|---|
| [`matlab-scientific-figures`](https://github.com/Kkkakania/matlab-scientific-figures) | 31 clean-room gallery examples, three electrical domain examples, static quality gates, figure-quality dogfooding, first-use feedback issue, release-cadence policy, `render_all.sh help examples` for shell users |
| [`matlab-figure-ci`](https://github.com/Kkkakania/matlab-figure-ci) | CLI/package tests, release-preflight checks, package artifact workflow, downstream dogfooding report, `init verification guidance` through `doctor` and `check` next steps |
| [`matlab-plotting-skill`](https://github.com/Kkkakania/matlab-plotting-skill) | first-render walkthrough, scheme readiness matrix, `stable first-use scheme list`, privacy/provenance checks, maintenance cadence |
| [`python-plotting-skill`](https://github.com/Kkkakania/python-plotting-skill) | early public Python Skill, synthetic Matplotlib gallery, repository quality check, first-use feedback issue, v0.2 template request issue |

## Fork And Pull Request Intake

As of the snapshot date, the tracked repositories have no open pull requests.
Recent public forks were checked against `main`; the visible fork branches for
the MATLAB repositories were behind the upstream repositories and did not
contain ahead commits to review or merge. `python-plotting-skill` had no visible
forks at the snapshot time. Treat forks and issue counts as maintenance context,
not as adoption metrics or pending contribution evidence.

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
| `python-plotting-skill` | 0 | 0 |

The latest visible forks included `Fantastic-wil2`, `Fantastic-wil`,
`Williamkakania`, and `Wppypepyyy` forks depending on repository. All checked
default branches were behind upstream `main`.

## External Pull Requests

| Project | Pull request | Status at snapshot | Scope |
|---|---|---|---|
| `matlab2tikz/matlab2tikz` | [`#1158`](https://github.com/matlab2tikz/matlab2tikz/pull/1158) | Merged | Fix a stale CONTRIBUTING link in the changelog |
| `fieldtrip/fieldtrip` | [`#2591`](https://github.com/fieldtrip/fieldtrip/pull/2591) | Open, mergeable | Clarify substantial feature contributions and extensions |
| `fieldtrip/website` | [`#927`](https://github.com/fieldtrip/website/pull/927) | Open, mergeable | Add an extension author checklist |
| `chebfun/chebfun` | [`#2495`](https://github.com/chebfun/chebfun/pull/2495) | Open, mergeable | Align workflow trigger and license link with the master branch |
| `scottclowe/matlab-schemer` | [`#47`](https://github.com/scottclowe/matlab-schemer/pull/47) | Open, mergeable | Fix documentation and MATLAB help-text typos |
| `PRML/PRMLT` | [`#54`](https://github.com/PRML/PRMLT/pull/54) | Open, mergeable | Fix README and MATLAB help-index typos |

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
