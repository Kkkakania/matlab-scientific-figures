#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

run_step() {
  echo "==> $1"
  shift
  "$@"
}

run_step "gallery outputs" ./scripts/check_gallery_outputs.sh
run_step "gallery metadata consistency" ./scripts/check_gallery_consistency.sh
run_step "version metadata consistency" ./scripts/check_version_consistency.sh
run_step "matlab-figure-ci dogfood version" ./scripts/check_mfigci_dogfood_version.sh
run_step "roadmap status language" ./scripts/check_roadmap_status.sh
run_step "maintainer activity bounds" ./scripts/check_maintainer_activity.sh
run_step "citation metadata" ./scripts/check_citation.sh
run_step "bilingual README" ./scripts/check_bilingual_readme.sh
run_step "documentation links" ./scripts/check_docs_links.sh
run_step "documentation link self-test" ./scripts/check_docs_links_selftest.sh
run_step "first-use feedback docs" ./scripts/check_first_use_docs.sh
run_step "domain examples docs" ./scripts/check_domain_examples_doc.sh
run_step "local resource intake docs" ./scripts/check_local_resource_intake.sh
run_step "fork intake retry" ./scripts/check_fork_intake_status_retry.sh
run_step "GitHub Project board docs" ./scripts/check_github_project_board_docs.sh
run_step "ecosystem handoff docs" ./scripts/check_ecosystem_handoff.sh
run_step "ecosystem issue label retry" ./scripts/check_ecosystem_issue_labels_retry.sh
run_step "ecosystem triage status retry" ./scripts/check_ecosystem_triage_status_retry.sh
run_step "maintainer workflow docs" ./scripts/check_maintainer_workflow.sh
run_step "Codex application draft" ./scripts/check_codex_application_draft.sh
run_step "application live snapshot retry" ./scripts/check_application_live_snapshot_retry.sh
run_step "Codex evidence note" ./scripts/check_codex_evidence_note.sh
run_step "application evidence packet" ./scripts/check_application_evidence_packet.sh
run_step "GitHub templates" ./scripts/check_issue_templates.sh
run_step "README first steps" ./scripts/check_readme_first_steps.sh
run_step "API reference self-test" ./scripts/check_api_reference_selftest.sh
run_step "API reference coverage" ./scripts/check_api_reference.sh
run_step "template manifest schema" ./scripts/check_template_manifest_schema.sh
run_step "template reference table" ./scripts/check_template_reference_table.sh
run_step "tag reference" ./scripts/check_tag_reference.sh
run_step "tag gallery" ./scripts/check_tag_gallery.sh
run_step "examples README table" ./scripts/check_examples_readme_table.sh
run_step "MATLAB help text" ./scripts/check_matlab_help.sh
run_step "README gallery preview" ./scripts/check_readme_gallery.sh
run_step "toolbox independence self-test" ./scripts/check_toolbox_independence_selftest.sh
run_step "toolbox independence" ./scripts/check_toolbox_independence.sh
run_step "compatibility docs" ./scripts/check_compatibility_docs.sh
run_step "JSON contract docs" ./scripts/check_json_contract_docs.sh
run_step "color accessibility audit" ./scripts/check_color_accessibility_audit.sh
run_step "CLI script static checks" ./scripts/check_cli_script_static.sh
run_step "render_all argument checks" ./scripts/check_render_all_args.sh
run_step "validate_gallery argument checks" ./scripts/check_validate_gallery_args.sh
run_step "timeout helper" ./scripts/check_timeout_helper.sh
run_step "scan script tempfiles" ./scripts/check_scan_script_tempfiles.sh
run_step "workflow maintenance settings" ./scripts/check_workflows.sh
run_step "forbidden file self-test" ./scripts/check_forbidden_files_selftest.sh
run_step "privacy self-test" ./scripts/check_privacy_selftest.sh
run_step "forbidden file scan" ./scripts/check_forbidden_files.sh
run_step "privacy pattern self-test" ./scripts/check_privacy_patterns_selftest.sh
run_step "privacy scan" ./scripts/check_privacy.sh
run_step "provenance pattern self-test" ./scripts/check_provenance_patterns_selftest.sh
run_step "provenance scan" ./scripts/check_provenance.sh

echo "Static quality checks passed."
