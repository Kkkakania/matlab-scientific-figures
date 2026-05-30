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
- Run the local checks before opening a pull request.

## Local Checks

```bash
./scripts/check_privacy.sh
./scripts/check_provenance.sh
./scripts/check_gallery_outputs.sh
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
