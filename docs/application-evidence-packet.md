# Application Evidence Packet

Snapshot date: 2026-06-20.

This packet gathers public evidence for reviewers who want to understand the
current MATLAB figure ecosystem without reading every maintenance document. It
is not a promise of Codex for Open Source eligibility, approval, credits, or
ChatGPT Pro access.

## Main Repository

For the current skill-first application story, use this repository as the main
application repository:

<https://github.com/Kkkakania/matlab-plotting-skill>

This is the repository that exposes the agent-facing MATLAB plotting skill and
the scientific diagram skill. `matlab-scientific-figures` remains the clean-room
gallery and MATLAB API evidence surface. `matlab-figure-ci` remains the
companion quality gate. The repos should be described as one maintenance
workflow, not as inflated adoption.

## Public Evidence To Cite

| Area | Evidence |
|---|---|
| Current release | [`v3.8.0`](https://github.com/Kkkakania/matlab-scientific-figures/releases/tag/v3.8.0) |
| Gallery and examples | [Gallery reference](gallery-reference.md), [template manifest](template-manifest.json), and committed PNG/SVG outputs |
| Quality gates | [Quality gates](quality-gates.md), [release checklist](release-checklist.md), and `./scripts/check_static_quality.sh` |
| CI | [`Quality checks`](https://github.com/Kkkakania/matlab-scientific-figures/actions/workflows/quality.yml) and [`Figure quality`](https://github.com/Kkkakania/matlab-scientific-figures/actions/workflows/figure-quality.yml) |
| PR review | [Pull request template](../.github/pull_request_template.md) with review evidence, local checks, risk/provenance, and release-note prompts |
| Issue intake | [Issue templates](../.github/ISSUE_TEMPLATE), [release readiness template](../.github/ISSUE_TEMPLATE/release_readiness.md), and [`issue-triage.yml`](../.github/workflows/issue-triage.yml) |
| Maintainer workflow | [Maintainer workflow](openai-codex-workflow.md), [maintainer dashboard](maintainer-dashboard.md), and [release cadence](release-cadence.md) |
| Clean-room boundary | [Provenance policy](provenance-policy.md), [local resource intake](local-resource-intake.md), and privacy/provenance checks |
| Dependency hygiene | [Security policy](../SECURITY.md), [`dependabot.yml`](../.github/dependabot.yml), and narrow workflow permissions |
| First-use feedback | [`matlab-scientific-figures#9`](https://github.com/Kkkakania/matlab-scientific-figures/issues/9) |
| Project-board tracking | [`matlab-scientific-figures#31`](https://github.com/Kkkakania/matlab-scientific-figures/issues/31), currently pending on GitHub Project scopes |
| Companion CI tool | [`matlab-figure-ci`](https://github.com/Kkkakania/matlab-figure-ci) for gallery, privacy, provenance, risky-file, and report checks |
| Primary skill repo | [`matlab-plotting-skill`](https://github.com/Kkkakania/matlab-plotting-skill) for agent-facing data-to-figure guidance |
| Diagram skill | [`scientific-diagram-skill`](https://github.com/Kkkakania/matlab-plotting-skill/tree/main/skills/scientific-diagram-skill) for Mermaid/draw.io research diagrams, with checked `.drawio` and `.svg` examples |
| Python sibling skill | [`python-plotting-skill`](https://github.com/Kkkakania/python-plotting-skill), an early Matplotlib Skill with synthetic gallery outputs and first-use feedback issues |

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

- The primary application repo is an early public MATLAB plotting skill.
- This gallery repo is the clean-room MATLAB API and example evidence surface.
- It uses clean-room source rules, deterministic synthetic examples, committed
  gallery outputs, and guarded quality checks.
- The maintainer workflow includes issue templates, a PR template, release
  readiness checks, provenance/privacy scans, GitHub Actions dependency
  maintenance, and companion CI tooling.
- Companion agent skills document two recurring maintainer tasks: choosing
  MATLAB figures from data and preparing clean research diagrams without
  copying paper figures or private screenshots.
- The Python plotting Skill is now public as a small sibling project. It should
  be cited as early cross-language evidence, not as proof of adoption.
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
practical agent-assisted plotting problem, not that it is already widely adopted.
