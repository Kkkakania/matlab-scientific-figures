# Template Backlog

This is the queue for figure types worth adding next. The list is based on
common research plotting needs: correlation, comparison, composition, time
change, density, and paper layouts.

The rule is simple: the public repo gets original MATLAB code, synthetic data,
gallery output, tests, and documentation. Reference material can guide the
choice of chart type, but source files are not copied into the repo.

## Already Covered

| Need | Example |
|---|---|
| Time trend | `line_plot` |
| Uncertainty band | `confidence_interval` |
| Dense x-y relationship | `density_scatter` |
| Method comparison | `grouped_bar`, `grouped_error_bar`, `butterfly_comparison` |
| Composition | `waffle_chart` |
| Matrix values | `heatmap`, `bubble_matrix` |
| Correlation matrix | `correlation_bubble`, `double_triangle_heatmap` |
| Distribution comparison | `box_jitter`, `ridgeline_plot` |
| Metric profile comparison | `radar_chart` |
| Multivariate sample comparison | `parallel_coordinates` |
| Ranking | `lollipop_ranking` |
| Signed change and local events | `positive_negative_area`, `zoomed_inset_line` |
| Multi-panel layout | `multi_panel_overview` |
| Smooth 3D response | `surface_3d` |

## High-Value Next Templates

| Priority | Template | Why it is useful |
|---|---|---|
| Medium | Sankey-style flow | Useful for flow or contribution structure, but needs careful API design |
| Medium | Contour scatter | Good for dense relationships where local structure matters |
| Later | 3D density scatter | Attractive, but only worth adding if the 2D version is not enough |
| Later | Texture-filled bars | Useful for grayscale printing, but easy to overdo |

## What Not To Add Yet

- Large algorithm collections.
- Image reference packs.
- Raw `.mat`, `.fig`, `.p`, `.xlsx`, `.docx`, or paper screenshots.
- Templates that need unclear local helper functions.
- Decorative charts that do not make the data easier to read.

## Adding A Backlog Item

Open a figure-template request issue with:

- the communication task
- the input data shape
- where the figure will be used
- any constraints such as long labels or grayscale printing

Then implement it as a normal example: data, renderer, gallery PNG/SVG, docs,
and tests.
