---
name: Release readiness
about: Track the evidence needed before tagging a public release
title: "[Release]: "
labels: release, ci, documentation
assignees: ""
---

## Release Readiness

Use this only when a coherent user-visible release is being prepared. Small
documentation, issue-intake, or maintenance-only changes can stay on `main`
until there is a real reason to tag.

## Coherent User-Visible Reason

- Proposed version:
- What changed for users:
- Why this should be a release instead of a main-branch maintenance update:

## Local Checks

- [ ] `./scripts/check_static_quality.sh`
- [ ] `./scripts/check_release_ready.sh`
- [ ] MATLAB-enforced release gate, or reason MATLAB was not available:

## GitHub Actions

- Quality checks workflow URL:
- Figure quality workflow URL:
- Commit SHA being released:

## Gallery, Docs, And Manifest

- [ ] Gallery outputs were reviewed by eye when examples changed.
- [ ] `docs/gallery-reference.md` thumbnails load.
- [ ] `docs/template-manifest.json` and `docs/template-reference.md` agree.
- [ ] README, Chinese README when relevant, and version-plan references are
      current.
- [ ] `CHANGELOG.md` has user-visible notes separated from maintenance notes.

## Risk And Boundary Review

- [ ] No private datasets, local paths, credentials, or identifying screenshots.
- [ ] No `.mat`, `.fig`, `.p`, Office files, archives, copied source packs, or
      unclear third-party material.
- [ ] No broad adoption, endorsement, or benefit-program approval claims unless
      public evidence is linked.
- [ ] Follow-up issues are opened instead of hiding unfinished work in release
      notes.

## Release Notes Draft

```text
User-visible:

Maintenance:

Known limits:
```
