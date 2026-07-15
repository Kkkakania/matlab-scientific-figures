# Application Evidence Packet

Snapshot date: 2026-07-15.

This packet gathers public evidence for reviewers who want to understand the
current MATLAB figure ecosystem without reading every maintenance document. It
is not a promise of Claude for Open Source eligibility, approval, or
subscription access.

## Main Repository

If the form asks for a single repository, use this repository as the main application repository:

<https://github.com/Kkkakania/matlab-scientific-figures>

Reason: this repo has the public release history, committed clean-room gallery,
MATLAB APIs, documentation, issue/PR templates, and quality gates. The skill
repositories are still important, but they should be cited as companion workflow evidence rather than used to make the application look larger than it
is. `matlab-plotting-skill` shows the agent-facing MATLAB workflow,
`matlab-figure-ci` shows the CI/quality gate, `scientific-diagram-skill` covers
research diagrams, and `python-plotting-skill` is a small cross-language sibling.

## Public Evidence To Cite

Checked with GitHub CLI on 2026-07-15. Refresh this table before submitting an
application if time has passed.

| Area | Evidence |
|---|---|
| Current release | [`v3.8.0`](https://github.com/Kkkakania/matlab-scientific-figures/releases/tag/v3.8.0) |
| Gallery and examples | [Gallery reference](gallery-reference.md), [template manifest](template-manifest.json), and committed PNG/SVG outputs |
| Quality gates | [Quality gates](quality-gates.md), [release checklist](release-checklist.md), and `./scripts/check_static_quality.sh` |
| CI | Commit `d01a86c`; [`Quality checks` run `29073068893`](https://github.com/Kkkakania/matlab-scientific-figures/actions/runs/29073068893) and [`Figure quality` run `29073068866`](https://github.com/Kkkakania/matlab-scientific-figures/actions/runs/29073068866), green and annotation-free (0 annotations) |
| PR review | [Pull request template](../.github/pull_request_template.md) with review evidence, local checks, risk/provenance, and release-note prompts |
| Issue intake | [Issue templates](../.github/ISSUE_TEMPLATE), [release readiness template](../.github/ISSUE_TEMPLATE/release_readiness.md), and [`issue-triage.yml`](../.github/workflows/issue-triage.yml) |
| Maintainer workflow | [Maintainer workflow](openai-codex-workflow.md), [maintainer dashboard](maintainer-dashboard.md), and [release cadence](release-cadence.md) |
| Clean-room boundary | [Provenance policy](provenance-policy.md), [local resource intake](local-resource-intake.md), and privacy/provenance checks |
| Dependency hygiene | [Security policy](../SECURITY.md), [`dependabot.yml`](../.github/dependabot.yml), and narrow workflow permissions |
| First-use feedback | [`matlab-scientific-figures#9`](https://github.com/Kkkakania/matlab-scientific-figures/issues/9) |
| Domain examples | [`matlab-scientific-figures#30`](https://github.com/Kkkakania/matlab-scientific-figures/issues/30) and [domain examples](domain-examples.md), currently covering `pv-power`, `harmonic-spectrum`, and `three-phase` with deterministic synthetic data |
| Project-board tracking | [`matlab-scientific-figures#31`](https://github.com/Kkkakania/matlab-scientific-figures/issues/31), currently pending on GitHub Project scopes |
| Companion CI tool | [`matlab-figure-ci`](https://github.com/Kkkakania/matlab-figure-ci) for gallery, privacy, provenance, risky-file, and report checks |
| Primary skill repo | [`matlab-plotting-skill`](https://github.com/Kkkakania/matlab-plotting-skill) for agent-facing data-to-figure guidance, with a 51-scheme catalog, unit-aware `stacked_time_series`, and redacted data-shape feedback summaries |
| Diagram skill | [`scientific-diagram-skill`](https://github.com/Kkkakania/scientific-diagram-skill) for Mermaid/draw.io research diagrams, with checked `.drawio` and `.svg` examples |
| Python sibling skill | [`python-plotting-skill`](https://github.com/Kkkakania/python-plotting-skill), an early Matplotlib skill with a 20-template synthetic gallery including `lollipop_ranking`, `paired_before_after`, and `category_small_multiples`, plus structured first-use/template-request intake and a README template-count guard |

## Companion Workflow Snapshot

These companion repositories are cited as maintenance workflow evidence, not as
separate adoption claims. The snapshot below was checked with `gh` on
2026-07-15 and should be refreshed before submitting an application.
Rows below are checked baselines, not latest-commit claims.

| Repository | Checked commit | Workflow evidence | Annotation status |
|---|---|---|---|
| [`matlab-figure-ci`](https://github.com/Kkkakania/matlab-figure-ci) | `f3ba856` | [`CI` run `29096995948`](https://github.com/Kkkakania/matlab-figure-ci/actions/runs/29096995948) and [`Package` run `29096996024`](https://github.com/Kkkakania/matlab-figure-ci/actions/runs/29096996024) | 0 annotations |
| [`matlab-plotting-skill`](https://github.com/Kkkakania/matlab-plotting-skill) | `1f82b1d` | [`Quality` run `29387457191`](https://github.com/Kkkakania/matlab-plotting-skill/actions/runs/29387457191), including the 51-scheme release gate, Diagram example validation, and refreshed Claude evidence | 0 annotations |
| [`scientific-diagram-skill`](https://github.com/Kkkakania/scientific-diagram-skill) | `b48540e` | [`Quality` run `29386480417`](https://github.com/Kkkakania/scientific-diagram-skill/actions/runs/29386480417), including `.drawio` XML, SVG preview, provenance, skill metadata, contribution/security/conduct entrypoints, README badge checks, and issue triage checklist | 0 annotations |
| [`python-plotting-skill`](https://github.com/Kkkakania/python-plotting-skill) | `72e569e` | [`Quality` run `29387445582`](https://github.com/Kkkakania/python-plotting-skill/actions/runs/29387445582), including the 20-template gallery, repository scan, and refreshed Claude evidence | 0 annotations |

## Verification Commands

Run these before reusing this packet in an application note:

```bash
./scripts/check_static_quality.sh
```

Then refresh the public GitHub snapshot before copying release, star, fork, or
CI wording into a form:

```bash
./scripts/check_application_live_snapshot.sh
```

The live snapshot checks both main-repository workflows and the current
`matlab-figure-ci`, `matlab-plotting-skill`, `scientific-diagram-skill`, and
`python-plotting-skill` workflows because this packet cites them as companion
evidence.

When MATLAB is available, run the release gate with MATLAB enforced:

```bash
MATLAB_BIN=/Applications/MATLAB_R2025a.app/bin/matlab REQUIRE_MATLAB=1 ./scripts/check_release_ready.sh
```

The hosted GitHub workflows do not prove that every MATLAB renderer was
executed on a GitHub runner. They prove that the committed repository passes the
non-MATLAB quality gates and the dogfooded `matlab-figure-ci` checks.

## Suggested Application Framing

Keep the framing factual and narrow:

- The primary application repo is `matlab-scientific-figures`.
- The companion skill repo shows how an agent can choose and render MATLAB
  figures from data.
- It uses clean-room source rules, deterministic synthetic examples, committed
  gallery outputs, and guarded quality checks.
- The maintainer workflow includes issue templates, a PR template, release
  readiness checks, provenance/privacy scans, GitHub Actions dependency
  maintenance, and companion CI tooling.
- Companion agent skills document two recurring maintainer tasks: choosing
  MATLAB figures from data and preparing clean research diagrams without
  copying paper figures or private screenshots. The diagram skill is now a
  separate public repository with its own quality workflow and first-use issue.
- The Python plotting skill is public as a small sibling project with 20
  synthetic Matplotlib templates. It should be cited as early cross-language
  evidence, not as proof of adoption.
- A Claude subscription would be used for PR review, issue triage, release-note
  drafting, CI failure analysis, and compact summaries of `matlab-figure-ci`
  reports.

## Boundaries

Do not claim broad adoption, high download volume, external endorsement, or
guaranteed benefit-program approval unless public evidence changes.

Do not cite private local folders, unreviewed figure packs, raw datasets,
screenshots, or non-public conversations. Do not use companion repositories to
make the main project look larger than it is.

The honest claim is that the main gallery has a real maintenance system around
a practical agent-assisted plotting problem. It is not already widely adopted.
