#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"

echo "=> Building site before starting Caddy"
"$ROOT_DIR/scripts/dev-build.sh"

echo "=> Starting Caddy via docker-compose"
docker compose up -d --build caddy

echo "Caddy started. Visit: http://localhost"
