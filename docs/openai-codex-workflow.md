# OpenAI Codex Workflow

This project is designed so AI assistance can help maintain quality without
becoming the source of truth.

## Useful Maintainer Workflows

- Review pull requests for MATLAB syntax, example coverage, and export behavior.
- Triage issues into rendering bugs, documentation gaps, template requests, and
  provenance concerns.
- Draft release notes from merged pull requests.
- Suggest chart-selection documentation for new examples.
- Check whether new templates include deterministic data and gallery output.

## Guardrails

- AI-generated code must pass the same tests and provenance checks.
- AI suggestions must not introduce copied third-party material.
- Maintainers should reject changes that add raw data packs or unclear assets.

## Candidate API Credit Uses

- Automated PR review comments for missing examples or docs.
- Issue labeling based on user reports.
- Release note drafts after each tagged version.
- Documentation consistency checks across examples and chart guide entries.
