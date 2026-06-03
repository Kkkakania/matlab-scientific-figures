# GitHub Project Board Plan

This page defines the recommended GitHub Projects setup for the MATLAB
scientific-figure ecosystem. It is a planning document for maintainers before
creating or updating the live board.

The goal is to make cross-repository maintenance visible without inflating
activity. The board should track real issues, reviews, release preparation, and
feedback loops across:

- [`matlab-scientific-figures`](https://github.com/Kkkakania/matlab-scientific-figures)
- [`matlab-figure-ci`](https://github.com/Kkkakania/matlab-figure-ci)
- [`matlab-plotting-skill`](https://github.com/Kkkakania/matlab-plotting-skill)

## Recommended Board

Name:

```text
MATLAB Scientific Figure Ecosystem
```

Description:

```text
Cross-repository roadmap for MATLAB scientific figures, figure quality checks,
and agent-assisted data-to-figure workflows.
```

This board should be public if possible. Public visibility makes the roadmap
easy for contributors to inspect, but it should not be used to imply adoption,
download volume, or external program eligibility.

## Fields

Use a small number of fields so the board stays maintainable.

| Field | Type | Suggested values |
|---|---|---|
| Status | Single select | Backlog, Ready, In progress, Needs review, Blocked, Done |
| Repository | Single select | scientific-figures, figure-ci, plotting-skill |
| Track | Single select | Gallery/API, Quality gate, Agent workflow, Documentation, Release, Feedback |
| Priority | Single select | P0, P1, P2, Later |
| Evidence level | Single select | Official/source-backed, Dogfooded, Needs user feedback, Proposal |
| Release target | Text | v3.x, v2.x, v0.x, no release planned |

Avoid fine-grained numeric scoring. The repositories already use qualitative
release and maintenance gates; the board should match that style.

## Views

### Roadmap

Purpose: show the main work that moves the ecosystem forward.

Filter:

```text
Status is not Done
```

Group by `Track`. Sort by `Priority`.

### Triage

Purpose: review new issues and external feedback.

Filter:

```text
Status is Backlog
```

Group by `Repository`. Sort by creation date.

### Release Readiness

Purpose: collect items that must be checked before a tag.

Filter:

```text
Track is Release
```

Group by `Release target`.

### Feedback Loops

Purpose: keep first-use testing and adoption reports visible.

Filter:

```text
Track is Feedback
```

Group by `Evidence level`.

### Cross-Repo Dependencies

Purpose: show work where one repository depends on another.

Filter:

```text
Repository is not empty
```

Group by `Repository`, then review linked issues manually.

## Starter Items

These issues are good initial board items because they represent real current
maintenance questions rather than synthetic tasks.

| Item | Repository | Track | Suggested priority | Evidence level |
|---|---|---|---|---|
| [`matlab-scientific-figures#9`](https://github.com/Kkkakania/matlab-scientific-figures/issues/9) | scientific-figures | Feedback | P1 | Needs user feedback |
| [`matlab-scientific-figures#30`](https://github.com/Kkkakania/matlab-scientific-figures/issues/30) | scientific-figures | Gallery/API | P2 | Proposal |
| [`matlab-figure-ci#1`](https://github.com/Kkkakania/matlab-figure-ci/issues/1) | figure-ci | Release | P1 | Official/source-backed |
| [`matlab-plotting-skill#11`](https://github.com/Kkkakania/matlab-plotting-skill/issues/11) | plotting-skill | Feedback | P1 | Needs user feedback |

When adding more items, prefer open issues or pull requests. Do not add private
tasks, unreviewed source packs, copied examples, or benefit-program application
claims to the public board.

## Maintenance Rhythm

Use the board as a weekly maintenance surface:

1. Triage new issues into a track and priority.
2. Move only items with a concrete next action into `Ready`.
3. Keep at most a few items in `In progress`.
4. Move release-related items to `Needs review` only after local checks and CI
   pass.
5. Archive completed items after the related issue, pull request, or release
   note is linked.

This rhythm supports a normal open-source maintenance story. It should not
create artificial releases or busywork.

## Scope Boundaries

The board should not track:

- raw data packs
- copied journal figures
- third-party plotting source trees
- private user data
- broad adoption, stars, downloads, or guaranteed approval claims
- speculative work with no linked issue or testable next step

Use the board to make real maintenance easier to inspect. Keep the evidence
level honest when an item is only a proposal or needs first-use feedback.
