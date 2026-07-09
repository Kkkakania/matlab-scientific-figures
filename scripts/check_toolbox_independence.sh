#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

toolbox_pattern='\b('\
'fitdist|ksdensity|histfit|boxplot|violinplot|parallelplot|'\
'pca|kmeans|regress|lasso|anova|corrplot|classificationLearner|'\
'groupsummary|findgroups|grpstats|fitlm|fitglm|fitcsvm'\
')\b'

if rg -ni --pcre2 "$toolbox_pattern" "$ROOT_DIR/src" "$ROOT_DIR/examples" "$ROOT_DIR/tests" \
  -g '*.m'; then
  cat >&2 <<'EOF'
Potential toolbox-only MATLAB calls found in public source or examples.
Keep gallery examples on base MATLAB APIs unless a dependency is documented and
accepted deliberately.
EOF
  exit 1
fi

echo "No blocked toolbox-only calls found in public MATLAB source."
