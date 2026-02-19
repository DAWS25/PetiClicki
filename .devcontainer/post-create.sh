#!/usr/bin/env bash
set -euo pipefail
echo "Running devcontainer post-create setup..."

# Make a Python venv for development tools
if [ ! -d ".venv" ]; then
  python3 -m venv .venv
fi
source .venv/bin/activate

pip install --upgrade pip

# Install some helpful Python tools locally
pip install --upgrade livereload || true

# Install devbox (optional helper). This mirrors Presence setup minimally.
if ! command -v devbox >/dev/null 2>&1; then
  echo "Installing devbox (jetify) locally..."
  curl -fsSL https://get.jetify.com/devbox | bash -s -- --force || true
fi

# Ensure direnv is allowed if .envrc exists
if [ -f ".envrc" ]; then
  if command -v direnv >/dev/null 2>&1; then
    direnv allow || true
  fi
fi

echo "Post-create steps completed. You may need to restart the container or reopen the workspace."
