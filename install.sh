#!/bin/bash
set -euo pipefail
if ! command -v chezmoi >/dev/null 2>&1; then
    sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$HOME/.local/bin" init --apply mcrowley1121
    export PATH="$HOME/.local/bin:$PATH"
else
    chezmoi init --apply mcrowley1121
fi
