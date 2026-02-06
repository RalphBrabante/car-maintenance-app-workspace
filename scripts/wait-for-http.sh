#!/usr/bin/env sh
set -e

URL="$1"
TIMEOUT="${2:-120}"
INTERVAL="${3:-2}"

if [ -z "$URL" ]; then
  echo "Usage: wait-for-http.sh <url> [timeout_seconds] [interval_seconds]"
  exit 1
fi

start=$(date +%s)

echo "Waiting for $URL (timeout ${TIMEOUT}s) ..."

while :; do
  if curl -fsS "$URL" >/dev/null 2>&1; then
    echo "Ready: $URL"
    exit 0
  fi

  now=$(date +%s)
  elapsed=$((now - start))
  if [ "$elapsed" -ge "$TIMEOUT" ]; then
    echo "Timed out waiting for $URL after ${TIMEOUT}s"
    exit 1
  fi

  sleep "$INTERVAL"
done
