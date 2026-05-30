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

For a new template named `correlation_bubble`:

- Add or extend deterministic data in `src/sftExampleData.m`.
- Add `examples/renderCorrelationBubble.m`.
- Add the renderer to `src/runAllExamples.m`.
- Add `gallery/correlation_bubble.png`.
- Add `gallery/correlation_bubble.svg`.
- Update `README.md`, `examples/README.md`, and
  `docs/chart-selection-guide.md`.

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
./scripts/check_gallery_outputs.sh
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
- The gallery includes PNG and SVG output.
- `runAllExamples` renders the new template.
- Tests pass.
- Privacy and provenance checks pass.
- Documentation explains when the template should be used.
