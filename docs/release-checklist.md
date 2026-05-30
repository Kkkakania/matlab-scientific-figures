# Release Checklist

Use this before tagging a release.

## Local Checks

```bash
MATLAB_BIN=/Applications/MATLAB_R2025a.app/bin/matlab ./scripts/render_all.sh
MATLAB_BIN=/Applications/MATLAB_R2025a.app/bin/matlab ./scripts/validate_gallery.sh
./scripts/check_gallery_outputs.sh
./scripts/check_privacy.sh
./scripts/check_provenance.sh
```

Run the MATLAB unit tests too:

```matlab
addpath(genpath('src'));
addpath(genpath('examples'));
results = [runtests('tests/test_sft_core.m'), ...
           runtests('tests/test_run_all_examples.m')];
assertSuccess(results);
```

## Manual Review

- Open the changed gallery images.
- Check long labels and legends.
- Check color accessibility with `docs/color-accessibility.md`.
- Check that SVG files render in the browser.
- Make sure new examples use synthetic data.
- Make sure docs explain when to use the new figure.

## GitHub

- Close issues that were actually fixed.
- Leave follow-up issues open instead of hiding TODOs in release notes.
- Update `CHANGELOG.md`.
- Tag the release after CI is green.
