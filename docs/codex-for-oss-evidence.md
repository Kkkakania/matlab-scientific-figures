# Codex For OSS Evidence Note

This note is a factual packet for a future Codex for Open Source application.
It is not a promise of eligibility, approval, credits, or ChatGPT Pro access.

## Repository To Use In The Form

Use this repository as the main application repository:

<https://github.com/Kkkakania/matlab-scientific-figures>

Reason: this repo is the public MATLAB figure library that users would clone,
run, and adapt. The companion repos are real maintenance infrastructure, but
they support this one rather than replacing it as the primary project.

## Current Public Signals

Snapshot date: 2026-06-19.

| Signal | Current evidence |
|---|---|
| Public repository | `Kkkakania/matlab-scientific-figures` is public |
| Current release | [`v3.8.0`](https://github.com/Kkkakania/matlab-scientific-figures/releases/tag/v3.8.0) |
| Public repo stats | 6 GitHub stars, 4 forks at the snapshot time |
| CI | `Quality checks` and `Figure quality` workflows are green on recent `main` commits |
| Maintainer workflow | issue templates, PR template, release checklist, release cadence, provenance policy, and quality gates |
| Active issue surfaces | first-use feedback, domain example proposals, and ecosystem Project-board tracking |
| Companion CI tool | [`matlab-figure-ci`](https://github.com/Kkkakania/matlab-figure-ci) checks gallery outputs, privacy, provenance, risky files, and report generation |
| Agent workflow | [`matlab-plotting-skill`](https://github.com/Kkkakania/matlab-plotting-skill) turns data-to-figure decisions into a repeatable agent-facing workflow |

Do not present these numbers as broad adoption. They are early public signals.

## Maintenance Chain Worth Citing

The strongest story is not "many repositories"; it is one maintained workflow:

1. `matlab-scientific-figures` provides clean-room MATLAB figure APIs, examples,
   gallery outputs, and docs.
2. `matlab-figure-ci` checks whether a figure repository is clean enough to
   publish: gallery outputs, risky files, privacy traces, provenance markers,
   and bounded reports.
3. `matlab-plotting-skill` documents how an AI agent can choose a plotting
   pattern, render figures, and produce a redacted first-use report.
4. Issues, PR templates, release gates, and changelog entries keep changes
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
- Summarize `mfigci` reports into compact maintainer notes.
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

`matlab-scientific-figures` is a clean-room MATLAB scientific plotting library
with reusable APIs, synthetic examples, committed gallery outputs, provenance
rules, and CI checks. It serves a practical need for students and engineers who
want publication-ready figures without copying unclear templates. The project is
early, but it already has release gates, issue/PR templates, first-use feedback,
and companion tooling for figure QA.

## Draft: API Credit Use

We would use OpenAI API credits for real maintainer work: PR review for docs,
manifest, provenance, and risky-file drift; issue triage for first-use reports;
release-note drafting from merged commits; CI failure analysis; and compact
summaries of `matlab-figure-ci` reports. The goal is to reduce review load while
keeping final decisions with the maintainer.

## Optional Extra Note

This is an early public project. The application should be honest about that.
The stronger claim is not adoption volume; it is that the repo already models a
careful maintenance workflow for MATLAB scientific figures, with clean-room
source rules, green quality gates, and a companion CI tool built for the same
problem.
