#!/usr/bin/env sh
set -e

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
ROOT_DIR=$(dirname "$SCRIPT_DIR")

cd "$ROOT_DIR"

# Start app first

docker compose up -d app

# Wait for app health endpoint
$SCRIPT_DIR/wait-for-http.sh "http://localhost:3000/health" 180 3

# Restart nginx once app is ready

docker compose restart nginx
