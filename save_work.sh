#!/usr/bin/env bash
# Zip one project (or all projects) from work/ into saved/ with a timestamp.
# Usage:  ./save_work.sh <project-name>    zip work/<project-name>
#         ./save_work.sh --all             zip the whole work/ folder
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
WORK="$ROOT/work"
SAVED="$ROOT/saved"
STAMP="$(date +%Y-%m-%d_%H%M)"
mkdir -p "$WORK" "$SAVED"

if [ $# -ne 1 ]; then
  echo "Usage: $0 <project-name> | --all"
  echo "Projects in work/:"; ls -1 "$WORK" 2>/dev/null || true
  exit 1
fi

cd "$WORK"
if [ "$1" = "--all" ]; then
  OUT="$SAVED/all-work_$STAMP.zip"
  zip -r -q "$OUT" . -x '*/node_modules/*' '*/.venv/*' '*/__pycache__/*'
else
  [ -d "$1" ] || { echo "No folder work/$1"; exit 1; }
  OUT="$SAVED/${1}_$STAMP.zip"
  zip -r -q "$OUT" "$1" -x '*/node_modules/*' '*/.venv/*' '*/__pycache__/*'
fi

echo "Saved: $OUT ($(du -h "$OUT" | cut -f1))"
echo "Contents:"; unzip -l "$OUT" | tail -n +4 | head -n -2
