# Template Author Guide

Use this guide when adding a new clean-room figure template.

## 1. Start With The Communication Task

Add a template only when it answers a clear plotting need:

- relationship
- uncertainty
- distribution
- ranking
- composition
- matrix pattern
- time trend
- spatial or surface response

If the task is already covered, improve the existing template instead of adding
a near-duplicate.

## 2. Use The Repository Structure

For a new template named `example_name`:

- Add or extend deterministic data in `src/sftExampleData.m`.
- Add `examples/renderExampleName.m`.
- Add the renderer to `src/sftTemplateRegistry.m`.
- Add `gallery/example_name.png`.
- Add `gallery/example_name.svg`.
- Update `README.md`, `examples/README.md`,
  `docs/template-reference.md`, and `docs/chart-selection-guide.md`.
- Update `scripts/check_gallery_outputs.sh` and `mfigci.yml`.

`runAllExamples` and `sftRenderExamples` read from the registry, so the
registry is the source of truth for public templates.

## 3. Keep Data Synthetic

Example data should be generated from code with a fixed seed. Do not include
private datasets, downloaded samples, copied figure data, or local file paths.

Good example data:

```matlab
rng(42);
x = linspace(0, 1, 80);
y = sin(2 * pi * x) + 0.08 * randn(size(x));
```

## 4. Follow The Rendering Contract

Each renderer should:

- accept `outputDir` and `formats`
- create a hidden figure
- use `sftTheme`, `sftPalette`, and `sftExport`
- apply stable labels and titles
- avoid relying on color alone for important distinctions
- close the figure after export
- return the exported file list

Example shape:

```matlab
function files = renderExampleName(outputDir, formats)
data = sftExampleData('example_name');
theme = sftTheme();

fig = figure('Visible', 'off', 'Units', 'centimeters', ...
    'Position', [1 1 theme.FigureSize]);

% Plot code goes here.

sftApplyTheme(gca, theme);
files = sftExport(fig, fullfile(outputDir, 'example_name'), formats);
close(fig);
end
```

## 5. Validate Before Release

Use the automated checks:

```matlab
report = sftValidateFigure(gcf);
disp(report)
```

Then run:

```bash
./scripts/check_release_ready.sh
```

If MATLAB is installed locally:

```bash
MATLAB_BIN=/Applications/MATLAB_R2025a.app/bin/matlab REQUIRE_MATLAB=1 ./scripts/check_release_ready.sh
```

Or run the smaller checks while iterating:

```bash
./scripts/check_gallery_outputs.sh
./scripts/check_gallery_consistency.sh
./scripts/check_forbidden_files.sh
./scripts/check_privacy.sh
./scripts/check_provenance.sh
```

## 6. Review The Provenance Boundary

Do not add:

- copied third-party plotting code
- encrypted MATLAB files
- journal image packs
- raw notes or screenshots
- local archive paths
- personal identifiers
- files with unclear rights

The public repository should stay reproducible from source code and synthetic
data only.

## Pull Request Checklist

- The chart has a clear task in `docs/chart-selection-guide.md`.
- The template is listed in `src/sftTemplateRegistry.m`.
- The template is listed in `docs/template-reference.md`.
- The gallery includes PNG and SVG output.
- Color choices have been reviewed with `docs/color-accessibility.md`.
- `sftRenderExamples("example_name")` renders the new template.
- Tests pass.
- Privacy and provenance checks pass.
- Documentation explains when the template should be used.
