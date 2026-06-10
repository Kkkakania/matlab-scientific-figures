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

## Current Creation Status

Live board creation is tracked in
[`matlab-scientific-figures#31`](https://github.com/Kkkakania/matlab-scientific-figures/issues/31).

As of 2026-06-04, the local `gh` token used for repository maintenance can read
and update issues, but it does not have GitHub Projects scopes. The CLI command
`gh project list --owner Kkkakania` returns a missing `read:project` scope error.
Until that token is refreshed or the board is created in the GitHub web UI, use
this document as the public setup checklist and seed queue.

To enable CLI setup later, refresh the token with:

```bash
gh auth refresh -s read:project -s project
```

Then verify:

```bash
gh project list --owner Kkkakania --limit 20
```

Or run the repository helper:

```bash
./scripts/check_github_project_board_status.sh
```

On machines where the board is still pending or the token has not been
refreshed, use the non-failing documentation mode:

```bash
./scripts/check_github_project_board_status.sh --allow-pending
```

While the live board is pending, use the repository triage helper to review the
same cross-repository open issues and pull requests without requiring GitHub
Projects scopes:

```bash
./scripts/check_ecosystem_triage_status.sh
```

Also keep the current open issues labeled. Labels are not a replacement for the
Project board, but they make the interim triage state visible while the board is
pending:

| Issue | Interim labels |
|---|---|
| [`matlab-scientific-figures#31`](https://github.com/Kkkakania/matlab-scientific-figures/issues/31) | `documentation`, `ci` |
| [`matlab-scientific-figures#30`](https://github.com/Kkkakania/matlab-scientific-figures/issues/30) | `template`, `enhancement` |
| [`matlab-scientific-figures#9`](https://github.com/Kkkakania/matlab-scientific-figures/issues/9) | `first-use`, `help wanted`, `good first issue`, `question` |
| [`matlab-figure-ci#1`](https://github.com/Kkkakania/matlab-figure-ci/issues/1) | `enhancement` |
| [`matlab-plotting-skill#11`](https://github.com/Kkkakania/matlab-plotting-skill/issues/11) | `testing`, `feedback` |

Maintainers can verify those labels with:

```bash
./scripts/check_ecosystem_issue_labels.sh
```

Do not close `#31` until a live public board exists or the issue explicitly
records that the web-created board has been verified.

## Fields

Use a small number of fields so the board stays maintainable.

| Field | Type | Suggested values |
|---|---|---|
| Status | Single select | Inbox, Triaged, Accepted, In progress, Awaiting feedback, Done |
| Repository | Single select | scientific-figures, figure-ci, plotting-skill |
| Track | Single select | gallery, agent, ci, ecosystem-docs |
| Priority | Single select | P0, P1, P2, Later |
| Evidence level | Single select | none, single-report, reproducible, ci-covered |
| Release target | Text | v3.x, v2.x, v0.x, PyPI candidate; leave blank when no release is planned |

Avoid fine-grained numeric scoring. The repositories already use qualitative
release and maintenance gates; the board should match that style.

The `Awaiting feedback` status is important for this ecosystem. First-use
reports, domain-pack proposals, and external tool feedback can be real work even
when no maintainer is actively editing code. Marking those items explicitly
keeps them from looking abandoned while still making the outside dependency
visible.

Use the evidence ladder conservatively:

- `none`: an idea or hunch with no checked reproduction yet.
- `single-report`: one external report or one maintainer observation.
- `reproducible`: a specific commit and command sequence that another person
  can rerun.
- `ci-covered`: the behavior is guarded by a current CI or static check.

The track names are intentionally short. They map to maintainer context switches
rather than marketing categories: `gallery` for MATLAB templates and rendering,
`agent` for the data-to-figure skill, `ci` for `matlab-figure-ci`, and
`ecosystem-docs` for cross-repository documentation and coordination.

## Views

### Roadmap

Purpose: show the main work that moves the ecosystem forward.

Filter:

```text
is:open
field:Status != Done
field:"Evidence level" != none
field:"Release target" not empty
```

Group by `Track`. Sort by `Priority` descending, then by `Repository`.

### Triage

Purpose: review new issues and external feedback.

Filter:

```text
Status is Inbox
```

Group by `Repository`. Sort by creation date.

### Release Readiness

Purpose: collect items that must be checked before a tag.

Filter:

```text
field:"Release target" not empty
```

Group by `Release target`.

### Feedback Loops

Purpose: keep first-use testing and adoption reports visible.

Filter:

```text
Status is "Awaiting feedback"
```

Sort by oldest update first. A reasonable maintenance target is to avoid leaving
anything in this view for more than 14 days without a maintainer ping or a
documented reason for waiting.

### Cross-Repo Dependencies

Purpose: show work where one repository depends on another.

Filter:

```text
Repository is not empty
```

Group by `Repository`, then review linked issues manually.

## Web Setup Checklist

If using the GitHub web UI:

1. Open `https://github.com/projects` and verify the active browser account is
   `Kkkakania` before clicking `New project`. The `gh` CLI account and the
   browser account can be different.
2. If the page shows another owner in the header or URL, stop and switch GitHub
   accounts before creating anything.
3. Create a new project named `MATLAB Scientific Figure Ecosystem`.
4. Add the description from this document.
5. Add the fields in the `Fields` table.
6. Create the five saved views in the `Views` section.
7. Add the current seed issues from the table below.
8. For each item, set `Repository`, `Track`, `Priority`, `Evidence level`, and
   `Release target`. Leave `Release target` blank when the item is not tied to a
   planned tag or publish decision.
9. Link the live project URL back to
   [`matlab-scientific-figures#31`](https://github.com/Kkkakania/matlab-scientific-figures/issues/31).

## Starter Items

These issues are good initial board items because they represent real current
maintenance questions rather than synthetic tasks.

| Item | Repository | Track | Suggested priority | Evidence level |
|---|---|---|---|---|
| [`matlab-scientific-figures#9`](https://github.com/Kkkakania/matlab-scientific-figures/issues/9) | scientific-figures | gallery | P1 | single-report |
| [`matlab-scientific-figures#30`](https://github.com/Kkkakania/matlab-scientific-figures/issues/30) | scientific-figures | gallery | P2 | ci-covered |
| [`matlab-figure-ci#1`](https://github.com/Kkkakania/matlab-figure-ci/issues/1) | figure-ci | ci | P1 | ci-covered |
| [`matlab-plotting-skill#11`](https://github.com/Kkkakania/matlab-plotting-skill/issues/11) | plotting-skill | agent | P1 | single-report |

When adding more items, prefer open issues or pull requests. Do not add private
tasks, unreviewed source packs, copied examples, or benefit-program application
claims to the public board.

## Current Seed Queue

Use this queue for the first board population. It reflects the open public
issues after the recent maintenance pass and avoids already-completed work.

| Item | Repository | Track | Suggested status | Suggested priority | Evidence level | Release target | Next action |
|---|---|---|---|---|---|---|---|
| [`matlab-scientific-figures#31`](https://github.com/Kkkakania/matlab-scientific-figures/issues/31) | scientific-figures | ecosystem-docs | In progress | P1 | reproducible | (blank) | Create or verify the live GitHub Project board. |
| [`matlab-scientific-figures#30`](https://github.com/Kkkakania/matlab-scientific-figures/issues/30) | scientific-figures | gallery | Awaiting feedback | P2 | ci-covered | (blank) | Wait for feedback on the PV and harmonic-spectrum examples before expanding the pack. |
| [`matlab-scientific-figures#9`](https://github.com/Kkkakania/matlab-scientific-figures/issues/9) | scientific-figures | gallery | Awaiting feedback | P1 | single-report | (blank) | Collect a fresh-clone first-use report. |
| [`matlab-figure-ci#1`](https://github.com/Kkkakania/matlab-figure-ci/issues/1) | figure-ci | ci | Triaged | P1 | ci-covered | PyPI candidate | Prepare PyPI only after package-name and install checks are current. |
| [`matlab-plotting-skill#11`](https://github.com/Kkkakania/matlab-plotting-skill/issues/11) | plotting-skill | agent | Awaiting feedback | P1 | single-report | (blank) | Collect first-use MATLAB rendering feedback. |

## Maintenance Rhythm

Use the board as a weekly maintenance surface:

1. Triage new issues into a track, priority, and evidence level.
2. Move only items with a concrete maintainer decision into `Accepted`.
3. Keep at most a few items in `In progress`.
4. Move outside-dependent items into `Awaiting feedback` and ping or document
   the waiting reason before they become stale.
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
