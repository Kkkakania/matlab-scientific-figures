# Chart Selection Guide

Choose the figure by the communication task first, not by decoration.

| Task | Recommended Example | Use When |
|---|---|---|
| Show time trend | `line_plot` | One or more signals change over an ordered axis |
| Show uncertainty | `confidence_interval` | Estimates need confidence bands or prediction ranges |
| Show signed change | `positive_negative_area` | Positive and negative deviations from a baseline both matter |
| Show group relationship | `scatter_plot` | Points belong to categories or operating states |
| Show dense relationship | `density_scatter` | Many points overlap and local density matters |
| Compare methods | `grouped_bar` | A few methods are compared across a few metrics |
| Compare methods with uncertainty | `grouped_error_bar` | Group means need visible uncertainty or variability |
| Compare two sides | `butterfly_comparison` | Two groups should be read from a shared zero baseline |
| Show composition | `waffle_chart` | Percent shares or progress counts should be compact and countable |
| Show matrix pattern | `heatmap` | Pairwise relations or sample-by-feature values matter |
| Show correlation strength | `correlation_bubble` | Positive and negative pairwise correlations both matter |
| Compare two matrices | `double_triangle_heatmap` | Two methods or conditions share the same pairwise layout |
| Show matrix magnitude | `bubble_matrix` | Matrix values need both position and magnitude cues |
| Show a local event | `zoomed_inset_line` | The full trend matters, but one interval needs detail |
| Compare distributions | `box_jitter` | Group spread and individual points both matter |
| Rank factors | `lollipop_ranking` | Ordered importance is more important than exact area |
| Combine panels | `multi_panel_overview` | Several small plots belong in one paper or slide figure |
| Show 3D field | `surface_3d` | A smooth response varies over two numeric inputs |

## First-Release Boundary

The first release intentionally avoids specialized maps, flow diagrams, and
domain-specific templates. Those should be added only after the core rendering,
testing, and provenance workflow is stable.

## Waffle Charts Versus Pie Charts

Use `waffle_chart` when the audience needs to compare a small number of
percentage shares and the countable 10 x 10 grid adds clarity. A waffle chart is
often easier to scan than a pie chart when the parts are close in size, but it
is not a good fit for many tiny categories or values that do not naturally sum
to a meaningful whole.

## Butterfly Comparisons

Use `butterfly_comparison` when the contrast between two sides matters more
than their absolute positions in separate panels. Keep the left and right
values positive in the input data; the renderer mirrors the left side around
zero so the sign convention is visible without changing the underlying values.
