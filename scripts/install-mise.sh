#!/usr/bin/env bash

set -euo pipefail

mise_bin="$HOME/.local/bin/mise"

if [[ ! -x "$mise_bin" ]]; then
  curl -fsSL https://mise.run | MISE_INSTALL_PATH="$mise_bin" sh
fi

"$mise_bin" --version
