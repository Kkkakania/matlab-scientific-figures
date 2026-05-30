#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

ROOT_DIR="$ROOT_DIR" node <<'NODE'
const fs = require('fs');
const path = require('path');

const root = process.env.ROOT_DIR;
const manifest = JSON.parse(
  fs.readFileSync(path.join(root, 'docs/template-manifest.json'), 'utf8')
);
const tagReference = fs.readFileSync(path.join(root, 'docs/tag-reference.md'), 'utf8');

const tagToTemplates = new Map();
for (const item of manifest) {
  for (const tag of item.Tags) {
    if (!tagToTemplates.has(tag)) {
      tagToTemplates.set(tag, []);
    }
    tagToTemplates.get(tag).push(item.Name);
  }
}

const errors = [];
const commonRowPattern = /^\| `([^`]+)` \| ([0-9]+) \| (.+) \|$/gm;
let commonRows = 0;
let match;
while ((match = commonRowPattern.exec(tagReference)) !== null) {
  const [, tag, countText, templatesText] = match;
  const actualTemplates = tagToTemplates.get(tag) || [];
  const expectedCount = actualTemplates.length;
  const documentedCount = Number(countText);
  commonRows += 1;

  if (documentedCount !== expectedCount) {
    errors.push(`Tag ${tag} count is ${documentedCount}; expected ${expectedCount}.`);
  }

  const documentedTemplates = [...templatesText.matchAll(/`([^`]+)`/g)].map((item) => item[1]);
  for (const templateName of documentedTemplates) {
    if (!actualTemplates.includes(templateName)) {
      errors.push(`Tag ${tag} lists ${templateName}, but the manifest does not assign that tag to it.`);
    }
  }
}

if (commonRows === 0) {
  errors.push('No common tag rows found in docs/tag-reference.md.');
}

const specificRowPattern = /^\| `([^`]+)` \| `([^`]+)` \|$/gm;
let specificRows = 0;
while ((match = specificRowPattern.exec(tagReference)) !== null) {
  const [, tag, templateName] = match;
  const actualTemplates = tagToTemplates.get(tag) || [];
  specificRows += 1;

  if (!actualTemplates.includes(templateName)) {
    errors.push(`Specific tag ${tag} points to ${templateName}, but the manifest does not match.`);
  }
}

if (specificRows === 0) {
  errors.push('No specific tag rows found in docs/tag-reference.md.');
}

if (errors.length > 0) {
  console.error(errors.join('\n'));
  process.exit(1);
}

console.log(`Tag reference matches the manifest (${commonRows} common rows, ${specificRows} specific rows).`);
NODE
