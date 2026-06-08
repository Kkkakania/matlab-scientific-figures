# Local Resource Intake

This repository sometimes uses local teaching folders, old plotting notebooks,
and personal example collections as inspiration for missing chart families.
Those folders are treated as a requirements source, not as source code.

The current local intake pass reviewed a private study-folder snapshot as a
read-only reference. The public repository did not copy files from that folder
and does not record the local path.

## What Was Observed

The local folder contains several kinds of material:

| Resource type | Public handling |
|---|---|
| Nature/Science figure image collections | Do not copy, redistribute, trace, or use as gallery assets |
| Origin projects and workbooks (`.opju`, `.opj`, `.ogwu`, `.opx`) | Treat as private/binary source material; do not publish |
| MATLAB binary or closed files (`.mat`, `.fig`, `.p`, `.mltbx`) | Do not publish; use only as a signal that binary-file checks matter |
| Third-party color tools and palette packs | Do not copy; prefer small original palettes or documented public sources |
| Clean-room learning notes and template names | Use as a chart-task map after rewriting data, code, labels, and examples |
| Electrical-engineering sketches | Convert only into deterministic synthetic examples with original code |

## Accepted Signals

The intake pass produced these safe signals for future work:

- The chart backlog should keep room for signal-processing figures such as FFT,
  Welch PSD, Bode/Nyquist, spectrogram, and step-response views.
- Electrical examples should stay focused on small, reproducible engineering
  tasks rather than broad domain packs.
- The CI/provenance tooling should flag Origin project files and MATLAB binary
  artifacts before they reach a public repository.
- Any paper-inspired layout should be described at the chart-family level, not
  copied from a specific journal figure.

## Rejected Inputs

Do not add any of these to the public repository:

- raw Nature or Science image packs;
- screenshots, OCR material, or copied paper figures;
- `.mat`, `.fig`, `.p`, `.opju`, `.opj`, `.ogwu`, `.opx`, Office files, or
  archives from local teaching folders;
- third-party MATLAB helper code with unclear license or provenance;
- generated outputs that still contain local paths, usernames, watermarks, or
  source-folder names.

## Clean-Room Conversion Rule

When a local resource suggests a useful figure, convert it through this process:

1. Write the communication task in one sentence.
2. Pick the closest existing template or document a new backlog candidate.
3. Generate deterministic synthetic data from scratch.
4. Write new MATLAB code using this repository's theme, palette, and export
   helpers.
5. Add docs, tests, and `mfigci` checks before publishing.
6. Record the provenance boundary in the issue or release note.

This page is a guardrail for maintenance. It is not a claim that the private
folder is open source, and it is not evidence of public adoption.
