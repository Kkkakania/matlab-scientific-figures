# Release Cadence

This project had a fast initial stabilization day on 2026-05-30. The early tags
were used to separate real milestones while the public API, CI, gallery checks,
and documentation structure were still settling.

Going forward, releases should slow down.

## Normal Maintenance Mode

After the first stabilization pass, routine work should accumulate on `main`
and in `CHANGELOG.md` without immediately creating a new tag. Prefer closing
small issue clusters with tested commits, then wait until several user-visible
changes naturally form a coherent release.

## Current Policy

- Keep `v3.5.0` as the current public release until a user-visible reason
  justifies another tag.
- Use patch releases, such as `v3.5.1`, for documentation fixes, CI checks,
  typo fixes, and small maintenance work.
- Use minor releases, such as `v3.6.0`, only when users get a new workflow,
  helper API, template, or documented behavior.
- Do not use another major release unless the public API or compatibility
  boundary changes in a way users must notice.

## What Does Not Need A Release

These changes can land on `main` without a tag:

- README wording.
- ROADMAP cleanup.
- Extra local checks.
- Issue template edits.
- Compatibility fixes that preserve the documented MATLAB floor.
- Palette, accessibility, or documentation clarifications that do not require a
  new install target.
- Small documentation navigation improvements.

## Release Checklist

Before tagging:

```bash
./scripts/check_release_ready.sh
```

When MATLAB is installed:

```bash
MATLAB_BIN=/Applications/MATLAB_R2025a.app/bin/matlab REQUIRE_MATLAB=1 ./scripts/check_release_ready.sh
```

Then check:

- `README.md` current public release matches the tag.
- `CHANGELOG.md` has a dated entry.
- `ROADMAP.md` describes the current state, not old planned work.
- `docs/release-cadence.md` points to the same current public release.
- GitHub Actions pass on `main`.

## Maintainer Note

Avoid version churn. The project should look maintained because issues,
documentation, tests, and releases are coherent, not because many tags were
published in a short time.
