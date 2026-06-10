# Maintainer Workflow

This page documents how the repository is maintained in public. It is written
for maintainers, reviewers, and contributors who want to understand how issue
triage, pull request review, release preparation, security boundaries, and code
quality checks fit together.

Automation can reduce repetitive review work, but it does not decide what
belongs in the project. A maintainer still checks the code, figure output,
source history, and provenance boundary before changes are merged.

## Maintenance Surfaces

| Surface | Public evidence | Maintainer action |
|---|---|---|
| Pull request review | PR template, CI checks, local check commands | Review changed files, ask for missing evidence, keep feedback specific |
| Issue triage | issue templates, labels, Project-board plan | Classify by track, evidence level, and next action |
| Release workflow | release checklist, release cadence, version plan | Batch coherent user-visible changes, avoid tag churn |
| Security and provenance | security policy, provenance policy, privacy scans | Reject private data, copied source packs, unclear licenses, or local paths |
| Code quality | static checks, MATLAB tests, figure quality checks | Run the smallest useful gate first, then MATLAB-enforced checks before release |

## Issue Triage

Every new issue should end in one of three states: actionable, waiting for
evidence, or out of scope.

Use these labels as the first pass:

- `bug`: reproducible rendering, export, API, or documentation failure.
- `template`: a new chart family, domain example, or missing workflow.
- `first-use`: fresh-clone feedback from a real user workflow.
- `ci`: quality gate, compatibility, privacy, provenance, or release-check
  improvement.
- `documentation`: docs, examples, recipes, or bilingual maintenance.
- `question`: unclear request that needs a smaller reproducible case.

Triage checklist:

1. Link the issue to the closest existing template, API, or check.
2. Ask for a synthetic reproducer when the report depends on private data.
3. Mark evidence level in the Project-board notes when the board is available:
   `none`, `single-report`, `reproducible`, or `ci-covered`.
4. Convert accepted feedback into one focused next action.
5. Close or defer work that depends on copied figures, raw data packs, unclear
   licensing, or untestable claims.

Do not use external accounts to manufacture activity. External accounts are
useful only when they provide real first-use reports, reproducible failures, or
pull requests that the maintainer can review on their merits.

## Pull Request Review

Use the PR template as the minimum review surface. For a template/API PR, the
maintainer should check:

- The change uses clean-room code and deterministic synthetic data.
- The public API has MATLAB help text and docs where behavior changed.
- `docs/template-reference.md`, the template manifest, and gallery docs stay
  consistent.
- PNG/SVG gallery outputs are present when a gallery-backed template changes.
- Figures close after export and do not leave global MATLAB state behind.
- No `.mat`, `.fig`, `.p`, Office files, archives, local paths, credentials, or
  unclear third-party source files were added.
- The contributor ran the relevant local checks or explained why a MATLAB-only
  check could not be run.

Assistant-assisted review is allowed for repetitive checks such as missing docs,
manifest drift, risky file extensions, privacy traces, or release-note drafts.
The maintainer remains responsible for accepting or rejecting the change.

## Release Workflow

This project should look maintained because issues, tests, docs, gallery
outputs, and release notes agree, not because tags are frequent.

Before a release:

1. Confirm the release has a coherent user-visible reason.
2. Run the non-MATLAB static gate:

   ```bash
   ./scripts/check_static_quality.sh
   ```

3. When MATLAB is available, run the MATLAB-enforced release gate:

   ```bash
   MATLAB_BIN=/Applications/MATLAB_R2025a.app/bin/matlab REQUIRE_MATLAB=1 ./scripts/check_release_ready.sh
   ```

4. Confirm GitHub Actions `Quality checks` and `Figure quality` are green.
5. Update release metadata consistently: README, Chinese README when relevant,
   ROADMAP, version plan, maintainer dashboard, changelog, and citation
   metadata.
6. Write release notes that separate user-visible changes from maintenance
   checks. Remove adoption, download, or benefit-program claims unless they are
   directly verifiable.

Small docs, issue-intake, and maintainer-workflow improvements can land on
`main` without a new release. Template/API changes should wait until gallery
outputs, docs, manifest, and tests move together.

## Security, Privacy, And Provenance

Security and provenance review is intentionally conservative:

- Do not publish private datasets, account-specific paths, credentials,
  screenshots, OCR packs, or user-identifying material.
- Do not copy third-party MATLAB helper libraries, paper figure packs, journal
  screenshots, or code with unclear license history.
- Treat provenance warnings as prompts for maintainer review, not as a license
  cleaning tool.
- Keep example data synthetic and deterministic.
- Report sensitive concerns through `SECURITY.md` instead of public issue text
  when private details would be exposed.

The public repository uses `matlab-figure-ci` to check committed files for
privacy traces, provenance markers, risky extensions, and gallery-output drift.

## Code Quality Gates

Use the smallest gate that matches the change:

| Change type | Minimum check |
|---|---|
| Docs or issue templates | `./scripts/check_static_quality.sh` |
| Gallery metadata or manifest | `./scripts/check_gallery_consistency.sh` plus static quality |
| MATLAB helper/API behavior | MATLAB Code Analyzer plus relevant `runtests` |
| Gallery-backed template | MATLAB render/export check plus `./scripts/check_release_ready.sh` |
| Public release | static quality, MATLAB-enforced release gate, and green GitHub Actions |

The hosted CI does not render MATLAB figures by default because public runners
normally do not include MATLAB. MATLAB-required checks remain a local release
responsibility.

## Candidate API Credit Uses

API credits or Codex should be used for real maintainer work:

- summarize new issues into triage notes and missing-evidence questions;
- review pull requests for docs, manifest, provenance, and risky-file drift;
- draft release notes from merged commits for maintainer editing;
- compare README, template reference, gallery outputs, and manifest entries;
- generate first-pass comments for incomplete bug reports or first-use reports;
- inspect CI failures and propose the smallest reproducible fix.

Do not use automation to manufacture stars, forks, comments, usage claims, or
fake adoption.

## Evidence Boundary

When describing this repository in an application or public maintainer note,
keep claims tied to evidence that can be checked:

- public repository and release links;
- committed gallery outputs and template manifest;
- local release-gate commands and results;
- GitHub Actions workflow results;
- dogfooding of `matlab-figure-ci`;
- issue links for first-use feedback and accepted maintenance work;
- public PR review or issue triage comments.

Do not present internal dogfooding as broad adoption. Do not invent stars,
downloads, user counts, or guaranteed program eligibility. If the project is
still early, say it is early and explain the maintenance system that already
exists.

## Evidence Packet

A maintainer can prepare a small evidence packet without turning it into a
marketing page:

1. Link the current release tag and the green `Quality checks` and
   `Figure quality` workflow runs for the same commit.
2. Include the static command that was run locally, such as
   `./scripts/check_static_quality.sh`, and note whether MATLAB-backed checks
   were run separately.
3. Link the template manifest, gallery preview, `mfigci.yml`, and
   `docs/local-resource-intake.md` so reviewers can see the clean-room boundary.
4. Link active issue-triage surfaces such as first-use feedback, the electrical
   example proposal, and the GitHub Project-board task.
5. Keep application text factual: "dogfooded by companion repositories" is
   acceptable when linked; "widely adopted" is not unless public usage evidence
   exists.

Use two packet shapes, depending on the job.

For a review packet, collect the commit, the relevant workflow run URL, the
local command summary, the issue or PR that motivated the change, and the files
that changed. If the change touches the ecosystem handoff, include
`mfigci-report.md` or `render_report.md` only as redacted summaries or CI
artifacts, not as copied raw output.

When the `matlab-figure-ci` working results are available, generate a compact
draft instead of writing the packet by hand:

```bash
mfigci report --style evidence --output mfigci-evidence.md
```

This report style is available on matlab-figure-ci main after v2.5.0. Do not
assume it is present in this repository's pinned `v2.5.0` figure-quality
workflow until a later `matlab-figure-ci` release is intentionally adopted.

For an application packet, keep the same evidence but remove maintainer-only
noise. Link the public repository, current release, green workflow run URL,
dogfooding workflow, clean-room policy, and one redacted issue or PR link that
shows real maintenance. This is not an approval argument. It is a compact way
to show what has been built and how it is checked.

Do not include private local folder paths, private screenshots, raw research
data, unreviewed prototype images, or claims about benefit-program approval.
