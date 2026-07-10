#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

ROOT_DIR="$ROOT_DIR" node <<'NODE'
const fs = require('fs');
const path = require('path');

const root = process.env.ROOT_DIR;
const manifestPath = path.join(root, 'docs/template-manifest.json');
const manifest = JSON.parse(fs.readFileSync(manifestPath, 'utf8'));
const registryPath = path.join(root, 'src/sftTemplateRegistry.m');
const registryText = fs.readFileSync(registryPath, 'utf8');
const registryNames = Array.from(
  registryText.matchAll(/makeTemplate\("([^"]+)"/g),
  (match) => match[1]
);

const requiredFields = [
  'Name',
  'OutputName',
  'RendererName',
  'Task',
  'Tags',
  'SyntheticDataKind',
  'SyntheticDataSeed',
  'SyntheticDataRng',
  'ExampleFile',
  'PngFile',
  'SvgFile',
];

const errors = [];
const seenNames = new Set();
const seenOutputs = new Set();

function existsNonEmpty(relativePath) {
  const fullPath = path.join(root, relativePath);
  return fs.existsSync(fullPath) && fs.statSync(fullPath).size > 0;
}

if (!Array.isArray(manifest)) {
  errors.push('Manifest root must be an array.');
} else {
  const manifestNames = manifest.map((item) => item.Name);
  if (registryNames.length === 0) {
    errors.push('Could not read template names from src/sftTemplateRegistry.m.');
  } else if (manifestNames.join('\n') !== registryNames.join('\n')) {
    errors.push('Manifest Name order must match src/sftTemplateRegistry.m.');
  }

  manifest.forEach((item, index) => {
    requiredFields.forEach((field) => {
      if (!(field in item)) {
        errors.push(`Entry ${index} is missing ${field}.`);
      }
    });

    if (typeof item.Name !== 'string' || !/^[a-z0-9_]+$/.test(item.Name)) {
      errors.push(`Entry ${index} has invalid Name: ${item.Name}`);
    }

    if (typeof item.OutputName !== 'string' || item.OutputName !== item.Name) {
      errors.push(`Entry ${index} OutputName must match Name.`);
    }

    if (typeof item.RendererName !== 'string' || !/^render[A-Za-z0-9]+$/.test(item.RendererName)) {
      errors.push(`Entry ${index} has invalid RendererName: ${item.RendererName}`);
    }

    if (typeof item.Task !== 'string' || item.Task.trim().length < 8) {
      errors.push(`Entry ${index} needs a clearer Task.`);
    }

    if (!Array.isArray(item.Tags) || item.Tags.length === 0 ||
        item.Tags.some((tag) => typeof tag !== 'string' || !/^[a-z0-9_-]+$/.test(tag))) {
      errors.push(`Entry ${index} has invalid Tags.`);
    }

    if (typeof item.SyntheticDataKind !== 'string' ||
        !/^[a-z0-9_+]+$/.test(item.SyntheticDataKind)) {
      errors.push(`Entry ${index} has invalid SyntheticDataKind: ${item.SyntheticDataKind}`);
    }

    if (!Number.isInteger(item.SyntheticDataSeed) || item.SyntheticDataSeed <= 0) {
      errors.push(`Entry ${index} has invalid SyntheticDataSeed: ${item.SyntheticDataSeed}`);
    }

    if (item.SyntheticDataRng !== 'twister') {
      errors.push(`Entry ${index} has invalid SyntheticDataRng: ${item.SyntheticDataRng}`);
    }

    const expectedExample = `examples/${item.RendererName}.m`;
    const expectedPng = `gallery/${item.OutputName}.png`;
    const expectedSvg = `gallery/${item.OutputName}.svg`;

    if (item.ExampleFile !== expectedExample) {
      errors.push(`${item.Name} ExampleFile should be ${expectedExample}.`);
    }

    if (item.PngFile !== expectedPng) {
      errors.push(`${item.Name} PngFile should be ${expectedPng}.`);
    }

    if (item.SvgFile !== expectedSvg) {
      errors.push(`${item.Name} SvgFile should be ${expectedSvg}.`);
    }

    [item.ExampleFile, item.PngFile, item.SvgFile].forEach((relativePath) => {
      if (!existsNonEmpty(relativePath)) {
        errors.push(`${item.Name} references missing or empty file: ${relativePath}`);
      }
    });

    if (seenNames.has(item.Name)) {
      errors.push(`Duplicate template name: ${item.Name}`);
    }
    seenNames.add(item.Name);

    if (seenOutputs.has(item.OutputName)) {
      errors.push(`Duplicate output name: ${item.OutputName}`);
    }
    seenOutputs.add(item.OutputName);
  });
}

if (errors.length > 0) {
  console.error(errors.join('\n'));
  process.exit(1);
}

console.log(`Template manifest schema is valid for ${manifest.length} templates.`);
NODE
