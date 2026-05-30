# Maintainer Workflow

Automation can help with review chores, but it should not decide what belongs
in the project. A maintainer still checks the code, the figure, and the source
history.

## Useful Automation

- Review pull requests for MATLAB syntax, example coverage, and export behavior.
- Triage issues into rendering bugs, documentation gaps, template requests, and
  provenance concerns.
- Draft release notes from merged pull requests.
- Suggest chart-selection documentation for new examples.
- Check whether new templates include deterministic data and gallery output.

## Rules

- Generated code must pass the same tests and provenance checks as human code.
- Suggestions must not introduce copied third-party material.
- Maintainers should reject changes that add raw data packs or unclear assets.

## Candidate API Credit Uses

- Automated PR review comments for missing examples or docs.
- Issue labeling based on user reports.
- Release note drafts after each tagged version.
- Documentation consistency checks across examples and chart guide entries.
