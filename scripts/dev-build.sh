#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
WEB_DIR="$ROOT_DIR/p8i_web"

echo "=> Building p8i_web (SvelteKit + Vite)"
cd "$WEB_DIR"

if [ -f package-lock.json ]; then
  echo "Using npm ci"
  npm ci
else
  echo "Installing node modules"
  npm install
fi

echo "Running build"
npm run build

echo "Build complete. Output directory: $WEB_DIR/build"
