#!/usr/bin/env bash
# Zip one project (or all projects) from work/ into saved/ with a timestamp,
# then commit the zip and push it to GitHub.
# Usage:  ./save_work.sh <project-name>    zip work/<project-name>
#         ./save_work.sh --all             zip the whole work/ folder
# Set NO_PUSH=1 to only make the zip without committing or pushing.
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

[ "${NO_PUSH:-}" = "1" ] && { echo "NO_PUSH=1: zip not committed or pushed."; exit 0; }

cd "$ROOT"
git rev-parse --is-inside-work-tree >/dev/null 2>&1 || { echo "Not a git repository: zip kept locally only."; exit 0; }
NAME="$(basename "$OUT")"
git add "saved/$NAME"
git commit -q -m "Save $NAME" -- "saved/$NAME"
BRANCH="$(git rev-parse --abbrev-ref HEAD)"
git pull -q --rebase origin "$BRANCH" || true
for wait in 2 4 8 16 0; do
  if git push -q -u origin "$BRANCH"; then
    echo "Pushed saved/$NAME to GitHub ($BRANCH)."
    exit 0
  fi
  [ "$wait" -gt 0 ] && { echo "Push failed, retrying in ${wait}s..."; sleep "$wait"; }
done
echo "PUSH FAILED: saved/$NAME is committed locally but NOT on GitHub yet."
exit 1
