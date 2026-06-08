# Domain Examples

Domain examples are standalone MATLAB examples that reuse the public plotting
helpers without expanding the core 30-template gallery registry. They are useful
for testing whether the library can support realistic research and engineering
stories while keeping the public repository clean-room and synthetic.

The electrical-engineering example pack is tracked in
[`matlab-scientific-figures#30`](https://github.com/Kkkakania/matlab-scientific-figures/issues/30).
Local teaching folders and plotting collections can suggest chart tasks, but
they are not copied into this repository. See
[Local resource intake](local-resource-intake.md) for the clean-room boundary.
The current implemented electrical examples are deliberately small:

| Command | MATLAB function | Output | Purpose |
|---|---|---|---|
| `./scripts/render_all.sh pv-power` | `renderPvPowerConfidence` | `pv_power_confidence` | Show a synthetic PV power forecast with uncertainty. |
| `./scripts/render_all.sh harmonic-spectrum` | `renderHarmonicSpectrum` | `harmonic_spectrum` | Compare synthetic power-quality harmonic spectra. |

Run them from the shell with a MATLAB executable:

```bash
SFT_OUTPUT_DIR=/tmp/sft-domain MATLAB_BIN=/Applications/MATLAB_R2025a.app/bin/matlab ./scripts/render_all.sh pv-power
SFT_OUTPUT_DIR=/tmp/sft-domain MATLAB_BIN=/Applications/MATLAB_R2025a.app/bin/matlab ./scripts/render_all.sh harmonic-spectrum
```

Or call them directly from MATLAB:

```matlab
addpath(genpath('src'));
addpath(genpath('examples'));
renderPvPowerConfidence('/tmp/sft-domain', ["png", "svg"]);
renderHarmonicSpectrum('/tmp/sft-domain', ["png", "svg"]);
```

## Feedback Wanted

For the electrical-engineering examples, feedback is most useful when it answers
specific questions:

- Does the example communicate a real power-systems or power-electronics task?
- Are the axis labels, units, and title understandable without extra context?
- Is the chart family appropriate, or would another existing template be
  clearer?
- Would this example help you choose a reusable plotting API for your own data?
- What is the smallest next electrical example that would add real value?

Do not attach private datasets, copied paper figures, lab screenshots, or
third-party plotting code. Synthetic input sketches, redacted command output,
and short descriptions are enough.

## Current Boundary

The pack should grow only when feedback points to a concrete missing task. A
good next example should include deterministic synthetic data, a standalone
renderer, shell entry point, documentation, and tests. It should not require a
new release by itself, and it should not turn the gallery into a domain-specific
dump.

No adoption, download, or approval claims are implied by these examples. They
are maintenance and design evidence only.

## Other Standalone Examples

The repository also contains other standalone examples such as
`directional-rose`, `marginal-scatter`, `raincloud`, `ribbon`, `vector-field`,
and `polar-bubble`. They follow the same clean-room rule, but they are not part
of the current electrical-engineering pack unless linked back to a specific
power or electrical workflow.
