# Chart Selection Guide

Choose the figure by the communication task first, not by decoration.

| Task | Recommended Example | Use When |
|---|---|---|
| Show time trend | `line_plot` | One or more signals change over an ordered axis |
| Show uncertainty | `confidence_interval` | Estimates need confidence bands or prediction ranges |
| Show group relationship | `scatter_plot` | Points belong to categories or operating states |
| Show dense relationship | `density_scatter` | Many points overlap and local density matters |
| Compare methods | `grouped_bar` | A few methods are compared across a few metrics |
| Show matrix pattern | `heatmap` | Pairwise relations or sample-by-feature values matter |
| Show matrix magnitude | `bubble_matrix` | Matrix values need both position and magnitude cues |
| Compare distributions | `box_jitter` | Group spread and individual points both matter |
| Rank factors | `lollipop_ranking` | Ordered importance is more important than exact area |
| Show 3D field | `surface_3d` | A smooth response varies over two numeric inputs |

## First-Release Boundary

The first release intentionally avoids specialized maps, flow diagrams, and
domain-specific templates. Those should be added only after the core rendering,
testing, and provenance workflow is stable.
