# Contributing

Contributions are welcome when they keep the project clean, reproducible, and
useful for scientific work.

## Rules

- Do not copy code from private archives or unclear third-party template packs.
- Do not add `.p`, `.fig`, `.mat`, raw article packages, journal image
  collections, screenshots, or watermarked assets.
- Use deterministic synthetic data for examples.
- Add or update a gallery example for every new template.
- Follow `docs/template-author-guide.md` for new renderers.
- Use `docs/template-review-checklist.md` before asking for review.
- Run the local checks before opening a pull request.

## Good First Contributions

The best first pull requests are small:

- Improve wording in one guide.
- Add a missing troubleshooting note.
- Tighten an existing template without changing its public name.
- Add a focused test for shared helper behavior.

For new templates, open an issue first. The template should solve a plotting
task that is not already covered by the gallery.

## Template Contribution Flow

For a new template, update these files together:

- `src/sftExampleData.m`
- `examples/renderExampleName.m`
- `src/sftTemplateRegistry.m`
- `gallery/example_name.png`
- `gallery/example_name.svg`
- `examples/README.md`
- `docs/template-reference.md`
- `docs/chart-selection-guide.md`
- `scripts/check_gallery_outputs.sh`
- `mfigci.yml`

If the change touches shared helpers, add or update MATLAB tests under `tests/`.
Avoid broad refactors in template pull requests; they are harder to review.

## Local Checks

```bash
./scripts/check_release_ready.sh
```

If MATLAB is installed, run the same gate with MATLAB enforced:

```bash
MATLAB_BIN=/Applications/MATLAB_R2025a.app/bin/matlab REQUIRE_MATLAB=1 ./scripts/check_release_ready.sh
```

Individual checks are still useful while iterating:

```bash
./scripts/check_forbidden_files.sh
./scripts/check_privacy.sh
./scripts/check_provenance.sh
./scripts/check_gallery_outputs.sh
./scripts/check_gallery_consistency.sh
MATLAB_BIN=/Applications/MATLAB_R2025a.app/bin/matlab ./scripts/validate_gallery.sh
```

For MATLAB rendering:

```bash
MATLAB_BIN=/Applications/MATLAB_R2025a.app/bin/matlab ./scripts/render_all.sh
```

For figure quality preflight:

```matlab
report = sftValidateFigure(gcf);
disp(report.Passed)
```
