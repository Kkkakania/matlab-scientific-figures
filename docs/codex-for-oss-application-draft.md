# Codex for OSS application draft

Snapshot date: 2026-06-21.

This page is a copy-ready draft for a future Codex for Open Source application.
Approval is not promised. Update the public stats and CI links before
submitting if time has passed.

## Repository to submit

Use this repository if the form asks for one GitHub repository:

```text
https://github.com/Kkkakania/matlab-scientific-figures
```

Do not submit three repositories as if they were separate adoption signals. The
supporting repositories are useful evidence, but the application should have one
main object:

- `matlab-scientific-figures`: main clean-room MATLAB gallery, APIs, docs, and release workflow.
- `matlab-figure-ci`: companion CI tool for gallery, privacy, provenance, risky-file, and report checks.
- `matlab-plotting-skill`: agent-facing MATLAB data-to-figure workflow.
- `python-plotting-skill`: early Python sibling used as cross-language evidence, not adoption proof.

## Verified public snapshot

Checked with GitHub CLI on 2026-06-21:

| Item | Evidence |
|---|---|
| Main repository | `Kkkakania/matlab-scientific-figures`, public |
| Current release | `v3.8.0` |
| Public stats | 6 stars, 4 forks at the snapshot time |
| Latest verified CI | `Quality checks` and `Figure quality` passed on `main` and were annotation-free at snapshot time |
| Main feedback surfaces | `#9` first-use feedback, `#30` domain examples, `#31` Project-board tracking |
| Companion checks | `matlab-figure-ci`, `mfigci.yml`, `mfigci-report.md`, and `.mfigci-results.json` |

These numbers are early public signals. Do not describe them as adoption volume.

## Form answer: why this repository qualifies

Use this as a starting point, then adjust to the exact form limit:

```text
matlab-scientific-figures is a clean-room MATLAB scientific figure library with deterministic gallery examples, reusable plotting APIs, committed PNG/SVG outputs, provenance/privacy checks, issue and PR templates, release checklists, and green CI. It is maintained with companion tooling: matlab-figure-ci for figure QA and matlab-plotting-skill for agent-assisted data-to-figure workflows.
```

Shorter version:

```text
matlab-scientific-figures is a clean-room MATLAB figure library with reproducible examples, reusable plotting APIs, committed gallery outputs, provenance/privacy checks, issue/PR templates, release gates, and green CI. It is paired with matlab-figure-ci and matlab-plotting-skill for real maintainer workflows.
```

## Form answer: how API credits or Codex would be used

```text
I would use Codex/API credits for real maintainer work: reviewing PRs for docs, manifest, provenance, and risky-file drift; triaging first-use issues into reproducible reports; summarizing mfigci reports; drafting release notes from merged commits; and investigating CI failures while keeping final release decisions with the maintainer.
```

## Optional extra note

```text
The project is early and should be evaluated as a maintained open-source workflow, not as an adoption-volume story. The value is the clean-room gallery, reproducible examples, quality gates, and companion tools for agent-assisted scientific plotting.
```

## 中文维护说明

表单如果只能填一个仓库，填 `matlab-scientific-figures`。这个仓库最适合作为主申请对象，因为它有 release、gallery、CI、issue/PR 模板、来源边界和维护文档。`matlab-figure-ci`、`matlab-plotting-skill`、`python-plotting-skill` 可以作为配套证据，但不要写成多个项目都有大量采用。

提交前只引用可复查事实：公开仓库、release、CI 链接、issue、PR、检查脚本和文档。不要写下载量、外部背书、公司认可或通过承诺。

## Pre-submit checks

Run this from the repository root before reusing the draft:

```bash
./scripts/check_static_quality.sh
```

Then refresh the live GitHub snapshot before copying stats or CI wording into a
form:

```bash
./scripts/check_codex_application_live_snapshot.sh
```

If MATLAB is available, also run:

```bash
MATLAB_BIN=/Applications/MATLAB_R2025a.app/bin/matlab REQUIRE_MATLAB=1 ./scripts/check_release_ready.sh
```
