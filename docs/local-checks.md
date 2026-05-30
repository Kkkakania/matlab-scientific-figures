# Local Checks

Use the smallest useful check while you are editing. Run the full gate before a
release or a pull request that changes templates, gallery output, or public API.

## Fast Static Checks

These checks do not start MATLAB:

```bash
./scripts/check_static_quality.sh
```

They cover committed gallery files, registry/documentation consistency, release
metadata, citation metadata, documentation links, API reference coverage,
manifest schema, MATLAB help summaries, README gallery preview, toolbox
independence, timeout helper behavior, forbidden files, privacy traces, and
provenance traces.

Use this when you changed docs, metadata, scripts, issue templates, or review
policy.

## Full Release Gate

Run the combined gate:

```bash
./scripts/check_release_ready.sh
```

When MATLAB is installed, enforce MATLAB checks too:

```bash
MATLAB_BIN=/Applications/MATLAB_R2025a.app/bin/matlab REQUIRE_MATLAB=1 ./scripts/check_release_ready.sh
```

This adds manifest regeneration, MATLAB unit tests, CLI rendering checks, and
the first-use smoke test.

## During Template Work

When iterating on one template, use a scratch output folder:

```bash
SFT_OUTPUT_DIR=/tmp/sft-gallery MATLAB_BIN=/Applications/MATLAB_R2025a.app/bin/matlab ./scripts/render_all.sh heatmap
```

Only regenerate and commit `gallery/` outputs when the figure is ready for
review.
