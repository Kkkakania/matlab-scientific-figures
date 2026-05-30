# Release Checklist

Use this before tagging a release.

## Local Checks

```bash
./scripts/check_release_ready.sh
```

Run the full local gate when MATLAB is installed:

```bash
MATLAB_BIN=/Applications/MATLAB_R2025a.app/bin/matlab REQUIRE_MATLAB=1 ./scripts/check_release_ready.sh
```

Regenerate the committed gallery only when examples changed:

```bash
MATLAB_BIN=/Applications/MATLAB_R2025a.app/bin/matlab ./scripts/render_all.sh
```

## Manual Review

- Open the changed gallery images.
- Open `docs/gallery-reference.md` and check that thumbnails load.
- Check long labels and legends.
- Check color accessibility with `docs/color-accessibility.md`.
- Check that SVG files render in the browser.
- Make sure new examples use synthetic data.
- Make sure docs explain when to use the new figure.
- Run `sftListTemplates()` and `sftFindTemplates("matrix")` from MATLAB if the
  registry changed.

## Version Files

- Update `CHANGELOG.md`.
- Update `README.md` current stable release.
- Update `docs/version-plan.md` when the release changes the public direction.
- Add a maintenance report for major releases.

## GitHub

- Close issues that were actually fixed.
- Leave follow-up issues open instead of hiding TODOs in release notes.
- Push the release commit and wait for CI to pass.
- Create the GitHub release after CI is green.
- Check the release page, badge, and tag workflow after publishing.
