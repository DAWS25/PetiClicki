#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"

echo "Stopping containers and removing build artifacts"
docker compose down --remove-orphans || true
rm -rf "$ROOT_DIR/p8i_web/build"

echo "Clean complete"
