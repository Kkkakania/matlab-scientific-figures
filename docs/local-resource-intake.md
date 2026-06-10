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

## Latest Intake Notes

The newer local snapshot adds breadth, not publishable material. It points to a
larger set of chart jobs that users may ask for:

| Signal | Public route |
|---|---|
| MATLAB x AI plotting notes | Improve data-inspection, recommendation, and report examples with new synthetic fixtures |
| MATLAB and Origin plotting books | Extract chart-family names only; do not reuse source files, screenshots, or workbook layouts |
| Signal-processing folders | Prioritize FFT, PSD, spectrogram, filter-response, group-delay, and envelope examples |
| Electrical-engineering examples | Keep small synthetic demos for power, impedance, harmonics, motor, and converter plots |
| 3D/scientific visualization material | Add only when a 3D view answers a real communication task better than a 2D view |
| Modeling and machine-learning examples | Treat ROC, lift, calibration, residual, SHAP-like, and learning-curve plots as backlog candidates |
| Larger clean-room template index | Treat the reported 239 template ideas and 60 palette families as a task map, not as source material or public adoption evidence |
| Go-side helpers and color-science utilities | Keep language/toolchain ideas at the workflow level; do not publish compiled helpers, local utility code, or generated audit outputs without a normal review |

The public decision is deliberately narrow: chart names can enter the backlog;
files, labels, screenshots, and code do not.

## Private Prototype Library Snapshot

A separate private prototype pass first produced a larger original learning
library with 216 Python templates, 216 MATLAB templates, 27 palette families,
and a small Origin scripting layer. A later private index reports broader
coverage: 239 template ideas, MATLAB/Python counterparts, 60 palette families,
Go-side helper experiments, Origin scripting notes, and color-science audit
material. That work is useful as a design sketch, but it is not automatically
part of this public repository.

The public intake from that prototype is limited to aggregate signals:

| Prototype signal | Public follow-up |
|---|---|
| 23+ chart categories | Keep the public backlog grouped by task, not by source folder |
| Strong electrical, signal, control, RF, ML, CFD, and optimization coverage | Promote these areas only when they can be rewritten with small synthetic datasets |
| Palette preview and color-science tooling | Improve public palette docs and color-accessibility checks before adding many styles |
| Origin Python and LabTalk scripts | Document interoperability boundaries; do not add Origin workbooks or copied scripts |
| 200+ generated gallery images | Treat as private visual QA only; public gallery images must be regenerated from public source |

This snapshot does not prove adoption, originality, or readiness by itself. Each
public template still needs a normal issue, new implementation, synthetic data,
gallery output, tests, and provenance notes.

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
