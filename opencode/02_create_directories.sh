#!/bin/bash

set -eu -o pipefail
# Uncomment for debug
# set -x

opencode_dir="${HOME}/opencode"

mkdir -p "${opencode_dir}/config"
mkdir -p "${opencode_dir}/local/share"
mkdir -p "${opencode_dir}/local/state"

# 'EOF' in single quotes disables expansion, so $schema is written literally
cat >"${opencode_dir}/config/opencode.json" <<'EOF'
{
  "$schema": "https://opencode.ai/config.json"
}
EOF
