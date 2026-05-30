# Color Accessibility

Use this checklist when reviewing gallery images, examples, and release
candidates. The goal is practical: figures should remain understandable for
readers with color-vision differences, grayscale printouts, and small README
thumbnails.

## Review Rules

- Do not encode the only important distinction with hue alone.
- Pair color with position, marker shape, line style, labels, annotations, or
  ordering when the categories are important.
- Keep foreground marks clearly separated from the white background.
- Check that legends are close enough to the plotted marks to avoid ambiguity.
- Prefer a small number of categories over a large rainbow palette.
- Review the PNG thumbnail and SVG export because they can fail differently.

## Current Gallery Audit

| Template | Color Risk | Review Note |
|---|---|---|
| `line_plot` | Medium | Uses line color; labels and legend should remain visible. |
| `confidence_interval` | Medium | Bands are color-coded; line identity should stay clear in legend. |
| `scatter_plot` | Medium | Group color carries meaning; marker overlap should be checked. |
| `density_scatter` | Low | Sequential color is supported by density structure. |
| `contour_scatter` | Low | Density color is reinforced by contour lines and overlaid points. |
| `grouped_bar` | Medium | Series rely on hue; legend and grouped position reduce risk. |
| `grouped_error_bar` | Medium | Series rely on hue; grouped position and error bars help. |
| `butterfly_comparison` | Low | Side and direction encode the main distinction; color is secondary. |
| `paired_slopegraph` | Low | Direction, slope, labels, and endpoint position carry the comparison. |
| `waffle_chart` | Medium | Category shares rely on hue and legend; keep category count small. |
| `sankey_flow` | Medium | Flow thickness carries magnitude, but node color and direct labels need review. |
| `ridgeline_plot` | Medium | Group color helps, but vertical position and labels carry the comparison. |
| `radar_chart` | Medium | Series use color, but polygon shape, metric labels, and legend support reading. |
| `parallel_coordinates` | Medium | Hue separates groups; repeated axes and median markers reduce ambiguity. |
| `positive_negative_area` | Low | Sign and baseline encode the main distinction. |
| `heatmap` | Low | Sequential scale is supported by colorbar. |
| `correlation_bubble` | Low | Sign and size help beyond hue. |
| `double_triangle_heatmap` | Low | Triangle position separates the two conditions. |
| `zoomed_inset_line` | Low | The inset and highlighted interval carry the main message. |
| `calendar_heatmap` | Low | Grid position, labels, and colorbar support the sequential scale. |
| `bubble_matrix` | Low | Bubble size supports the color scale. |
| `box_jitter` | Medium | Groups use color, but x-position and labels also encode categories. |
| `lollipop_ranking` | Low | Ranking position carries the message. |
| `multi_panel_overview` | Medium | Multiple encodings appear; review each panel after changes. |
| `surface_3d` | Low | Shape and colorbar both communicate the field. |

## Release Review

Before tagging a release, manually open changed gallery PNGs at README-like
size and answer:

- Can I identify each series without relying only on color?
- Does the figure still make sense if printed in grayscale?
- Are text labels, legends, and colorbars large enough?
- Would adding a marker, line style, direct label, or annotation reduce
  ambiguity?

This repository keeps the first pass as a manual checklist. Automated color
simulation or contrast scoring can be added later, but it should not introduce
heavy dependencies or block valid scientific figures with noisy warnings.
