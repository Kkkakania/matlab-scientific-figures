# Application Evidence Packet

Snapshot date: 2026-06-20.

This packet gathers public evidence for reviewers who want to understand the
current MATLAB figure ecosystem without reading every maintenance document. It
is not a promise of Codex for Open Source eligibility, approval, credits, or
ChatGPT Pro access.

## Main Repository

Use this repository as the main application repository:

<https://github.com/Kkkakania/matlab-scientific-figures>

This is the repository that users would clone to inspect the MATLAB APIs,
examples, synthetic data generators, gallery outputs, and documentation. The
companion repositories support maintenance and agent workflows, but they should
not be used to inflate the main repository.

## Public Evidence To Cite

| Area | Evidence |
|---|---|
| Current release | [`v3.8.0`](https://github.com/Kkkakania/matlab-scientific-figures/releases/tag/v3.8.0) |
| Gallery and examples | [Gallery reference](gallery-reference.md), [template manifest](template-manifest.json), and committed PNG/SVG outputs |
| Quality gates | [Quality gates](quality-gates.md), [release checklist](release-checklist.md), and `./scripts/check_static_quality.sh` |
| CI | [`Quality checks`](https://github.com/Kkkakania/matlab-scientific-figures/actions/workflows/quality.yml) and [`Figure quality`](https://github.com/Kkkakania/matlab-scientific-figures/actions/workflows/figure-quality.yml) |
| PR review | [Pull request template](../.github/pull_request_template.md) with review evidence, local checks, risk/provenance, and release-note prompts |
| Issue intake | [Issue templates](../.github/ISSUE_TEMPLATE) and [`issue-triage.yml`](../.github/workflows/issue-triage.yml) |
| Maintainer workflow | [Maintainer workflow](openai-codex-workflow.md), [maintainer dashboard](maintainer-dashboard.md), and [release cadence](release-cadence.md) |
| Clean-room boundary | [Provenance policy](provenance-policy.md), [local resource intake](local-resource-intake.md), and privacy/provenance checks |
| First-use feedback | [`matlab-scientific-figures#9`](https://github.com/Kkkakania/matlab-scientific-figures/issues/9) |
| Project-board tracking | [`matlab-scientific-figures#31`](https://github.com/Kkkakania/matlab-scientific-figures/issues/31), currently pending on GitHub Project scopes |
| Companion CI tool | [`matlab-figure-ci`](https://github.com/Kkkakania/matlab-figure-ci) for gallery, privacy, provenance, risky-file, and report checks |
| Agent workflow | [`matlab-plotting-skill`](https://github.com/Kkkakania/matlab-plotting-skill) for agent-facing data-to-figure guidance |

## Verification Commands

Run these before reusing this packet in an application note:

```bash
./scripts/check_static_quality.sh
```

When MATLAB is available, run the release gate with MATLAB enforced:

```bash
MATLAB_BIN=/Applications/MATLAB_R2025a.app/bin/matlab REQUIRE_MATLAB=1 ./scripts/check_release_ready.sh
```

The hosted GitHub workflows do not prove that every MATLAB renderer was
executed on a GitHub runner. They prove that the committed repository passes the
non-MATLAB quality gates and the dogfooded `matlab-figure-ci` checks.

## Suggested Application Framing

Keep the framing factual and narrow:

- The project is an early public MATLAB scientific plotting library.
- It uses clean-room source rules, deterministic synthetic examples, committed
  gallery outputs, and guarded quality checks.
- The maintainer workflow includes issue templates, a PR template, release
  readiness checks, provenance/privacy scans, and companion CI tooling.
- API credits or Codex would be used for PR review, issue triage, release-note
  drafting, CI failure analysis, and compact summaries of `matlab-figure-ci`
  reports.

## Boundaries

Do not claim broad adoption, high download volume, external endorsement, or
guaranteed benefit-program approval unless public evidence changes.

Do not cite private local folders, unreviewed figure packs, raw datasets,
screenshots, or non-public conversations. Do not use companion repositories to
make the main project look larger than it is.

The honest claim is that the project has a real maintenance system for a
practical MATLAB plotting problem, not that it is already widely adopted.
