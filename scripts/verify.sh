#!/bin/bash
# Builds Backdrop, then renders every look headlessly in a tall and a wide
# frame and checks that each still was written and is not blank. About three
# minutes on an M2.
#
#   bash scripts/verify.sh [parent-folder]
#
# Writes into a backdrop-verify folder inside the parent (the temporary folder
# by default), replacing only that folder.
set -uo pipefail
PARENT="${1:-${TMPDIR:-/tmp}}"
mkdir -p "$PARENT" || exit 1
PARENT="$(cd "$PARENT" && pwd)"
cd "$(dirname "$0")/.."
OUT="$PARENT/backdrop-verify"
rm -rf "$OUT"
mkdir -p "$OUT"

bash scripts/build.sh release > "$OUT/build.log" 2>&1 || { echo "build: FAILED (see $OUT/build.log)"; exit 1; }
APP="../dist/Backdrop.app/Contents/MacOS/Backdrop"

LOOKS="studio softbloom mesh fade paper riso wash ink halo aurora bloom leak bokeh rays fluted frost contours silk linefield ridgelines dunes smoke marble chrome lava cells halftone dotgrid matrix"
failures=0
count=0
for look in $LOOKS; do
  for format in reel landscape; do
    file="$OUT/$look-$format.png"
    "$APP" --still "$file" --scene "$look" --format "$format" --time 2 >/dev/null 2>&1
    count=$((count + 1))
    # A blank frame compresses to almost nothing; a look never does.
    size=$(stat -f %z "$file" 2>/dev/null || echo 0)
    if [ "$size" -lt 20000 ]; then
      printf '%-24s FAIL %s bytes\n' "$look ($format)" "$size"
      failures=$((failures + 1))
    fi
  done
done

if [ "$failures" -eq 0 ]; then
  echo "All $count stills rendered. Output in $OUT"
else
  echo "$failures of $count stills failed. Output in $OUT"
  exit 1
fi
