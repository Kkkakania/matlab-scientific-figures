# Codex For OSS Evidence Note

This note is a factual packet for a future Codex for Open Source application.
It is not a promise of eligibility, approval, credits, or ChatGPT Pro access.
For a shorter reviewer-facing packet, use
[Application evidence packet](application-evidence-packet.md).

## Repository To Use In The Form

If the form asks for a single repository, use the main gallery/API repository:

<https://github.com/Kkkakania/matlab-scientific-figures>

Reason: this repo has the public release history, clean-room MATLAB gallery,
reusable APIs, documentation, issue/PR workflow, and CI evidence. The stronger
story is still broader than a gallery: `matlab-plotting-skill` demonstrates the
agent-facing data-to-figure workflow, and `matlab-figure-ci` demonstrates the
quality gate used to keep figure repositories publishable. Cite those as
companion repositories, not as separate adoption claims.

## Current Public Signals

Snapshot date: 2026-06-22.

| Signal | Current evidence |
|---|---|
| Public repository | `Kkkakania/matlab-scientific-figures` is public |
| Current release | [`v3.8.0`](https://github.com/Kkkakania/matlab-scientific-figures/releases/tag/v3.8.0) |
| Public repo stats | 6 GitHub stars, 4 forks at the snapshot time |
| CI | `Quality checks` and `Figure quality` workflows are green and annotation-free on the current checked `main` snapshot |
| Maintainer workflow | issue templates, PR template, release checklist, release cadence, provenance policy, and quality gates |
| Active issue surfaces | first-use feedback, domain example proposals, and ecosystem Project-board tracking |
| Companion CI tool | [`matlab-figure-ci`](https://github.com/Kkkakania/matlab-figure-ci) checks gallery outputs, privacy, provenance, risky files, and report generation |
| Primary skill repo | [`matlab-plotting-skill`](https://github.com/Kkkakania/matlab-plotting-skill) turns data-to-figure decisions into a repeatable agent-facing workflow, now including a 51-scheme catalog, unit-aware `stacked_time_series` labels, and redacted data-shape feedback summaries |
| Diagram skill | [`scientific-diagram-skill`](https://github.com/Kkkakania/matlab-plotting-skill/tree/main/skills/scientific-diagram-skill) covers clean Mermaid/draw.io research diagrams, including checked `.drawio` and `.svg` examples |
| Python sibling skill | [`python-plotting-skill`](https://github.com/Kkkakania/python-plotting-skill) is public, green on CI, and has a 15-template Matplotlib gallery plus first-use/template-request issue surfaces |

Companion snapshot checked on 2026-06-22:

| Repository | Evidence boundary |
|---|---|
| `matlab-figure-ci` | commit `877b589`; `CI` run `27920162827` and `Package` run `27920162825`, both successful with 0 annotations; release-preflight JSON now includes package name and version |
| `matlab-plotting-skill` | commit `49711e1`; `Quality` run `27923803978`, successful with 0 annotations; added `--data-shape` feedback summaries after the unit-aware `stacked_time_series` label work |
| `python-plotting-skill` | commit `0c76af2`; `Quality` run `27924618583`, successful with 0 annotations; corrected the public 15-template README count after `category_small_multiples` and refreshed the Python application-evidence snapshot |

Do not present these numbers as broad adoption. They are early public signals.
Run `./scripts/check_codex_application_live_snapshot.sh` before copying any
release, star, fork, or CI wording into an application form.

## Maintenance Chain Worth Citing

The strongest story is not "many repositories"; it is one maintained workflow:

1. `matlab-plotting-skill` gives an agent a repeatable path for choosing a
   MATLAB chart, rendering it, collecting a redacted report, and handing the
   result back for maintainer review.
2. `matlab-figure-ci` checks whether a figure repository is clean enough to
   publish: gallery outputs, risky files, privacy traces, provenance markers,
   and bounded reports.
3. `matlab-scientific-figures` provides the clean-room MATLAB figure APIs,
   examples, gallery outputs, and docs that the skill can point users toward.
4. `scientific-diagram-skill` covers method diagrams, system blocks, signal
   chains, and draw.io exports without copying paper figures or private
   screenshots.
5. `python-plotting-skill` records the Python side of the same problem with a
   small Matplotlib gallery, synthetic data, and issue intake for first-use
   feedback.
6. Issues, PR templates, release gates, and changelog entries keep changes
   reviewable instead of relying on ad hoc commits.

One recent example is
[`matlab-figure-ci#35`](https://github.com/Kkkakania/matlab-figure-ci/issues/35)
to
[`matlab-figure-ci#36`](https://github.com/Kkkakania/matlab-figure-ci/pull/36):
an issue with acceptance criteria, a PR, CI checks, a maintainer review comment,
and a squash merge.

## How Codex/API Credits Would Be Used

- Review PRs for missing docs, manifest drift, risky file extensions, and
  provenance warnings.
- Triage first-use issues into reproducible reports, missing-evidence questions,
  or out-of-scope notes.
- Draft release notes from merged commits for maintainer editing.
- Compare README, template reference, gallery outputs, and manifest entries
  before releases.
- Produce compact summaries of `matlab-figure-ci` reports for maintainer review.
- Investigate CI failures and propose the smallest fix that preserves the
  clean-room and privacy boundaries.

## What Not To Claim

- Do not claim wide adoption, high download volume, or ecosystem importance
  beyond what public evidence supports.
- Do not claim third-party endorsement, platform endorsement, or guaranteed
  program approval.
- Do not cite private local folders, unreviewed figure packs, screenshots, or
  non-public conversations.
- Do not use the companion repos to inflate the main project. Describe them as
  supporting maintenance tools.

## Draft: Why This Repository Qualifies

`matlab-scientific-figures` is a clean-room MATLAB gallery and plotting API
library for scientific figures. It gives Codex a concrete maintenance surface:
checked examples, deterministic synthetic data, quality gates, release
checklists, issue/PR templates, and a companion workflow for agent-assisted
data-to-figure rendering through `matlab-plotting-skill`. The ecosystem is
early, but it already has provenance checks, green CI, and a companion CI tool
for figure QA.

## Draft: API Credit Use

We would use OpenAI API credits for real maintainer work: PR review for docs,
manifest, provenance, and risky-file drift; issue triage for first-use reports;
release-note drafting from merged commits; CI failure analysis; and compact
summaries of `matlab-figure-ci` reports. The goal is to reduce review load while
keeping final decisions with the maintainer.

## Optional Extra Note

This is an early public ecosystem. The application should be honest about that.
The stronger claim is not adoption volume; it is that the repos already model a
careful maintainer workflow for agent-assisted scientific figures: skill
instructions, clean-room gallery evidence, green quality gates, and a companion
CI tool built for the same problem.
