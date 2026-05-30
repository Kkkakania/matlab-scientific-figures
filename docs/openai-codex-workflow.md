# Maintainer Workflow

Automation can help with review chores, but it should not decide what belongs
in the project. A maintainer still checks the code, the figure, and the source
history.

## Issue Triage

Use an assistant to sort new issues into a short set of labels:

- `template request`
- `bug`
- `documentation`
- `quality gate`
- `provenance`

For template requests, ask for the data shape, target output, closest existing
template, and any journal or slide constraints. Close requests that depend on
private data or copied assets unless the user can restate the need without
shipping those materials.

## Pull Request Review

Use Codex or API-backed checks to review boring details before the maintainer
does the final read:

- Does the PR update `sftTemplateRegistry`?
- Does `docs/template-reference.md` match the registry?
- Are gallery PNG and SVG outputs present?
- Does the renderer close figures after export?
- Does the example use deterministic synthetic data?
- Are there risky file reads, shell calls, binary assets, or local paths?

The assistant can draft comments, but the maintainer should decide whether the
chart belongs in the project.

## Release Work

For each release:

1. Run `./scripts/check_release_ready.sh`.
2. Run the MATLAB-enforced gate locally when MATLAB is available.
3. Ask an assistant to summarize merged commits into `CHANGELOG.md`.
4. Re-read the release notes by hand and remove vague claims.
5. Publish the tag only after CI is green.

## Rules

- Generated code must pass the same tests and provenance checks as human code.
- Suggestions must not introduce copied third-party material.
- Maintainers should reject changes that add raw data packs or unclear assets.
- Do not use automation to manufacture stars, comments, or fake usage.

## Candidate API Credit Uses

- PR review comments for missing examples, docs, or registry updates.
- Issue labeling and first-response drafts for incomplete bug reports.
- Release note drafts from commit history.
- Documentation consistency checks across examples, gallery reference, and chart
  guide entries.
- Provenance and privacy review before major releases.

## Evidence Boundary

When this project is described in an application or public maintainer note, keep
the claims tied to evidence that can be checked:

- public repository and release links
- committed gallery outputs and template manifest
- local release-gate results
- GitHub Actions workflow results
- dogfooding of `matlab-figure-ci`
- issue links for first-use feedback and template requests

Do not present internal dogfooding as broad adoption. Do not invent stars,
downloads, user counts, or guaranteed program eligibility. If the project is
still early, say it is early and explain the maintenance system that already
exists.
