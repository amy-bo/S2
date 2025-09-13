#!/usr/bin/env bash
set -euo pipefail

outdir="scripts/output/repo-report"
mkdir -p "$outdir"

# 1) List of tracked files with sizes (safe: from Git, no absolute paths)
git ls-tree -r --long HEAD \
  | sed -E 's/^[0-9]{6} [a-z]+ [0-9a-f]{40} +([0-9]+)\t/\1\t/' \
  > "$outdir/filelist.txt"

# 2) Top 20 largest tracked files
sort -nr "$outdir/filelist.txt" | head -20 > "$outdir/largest.txt"

# 3) Human-friendly directory size summary (excluding heavy/ephemeral dirs)
du -h -d 2 . \
  | egrep -v '\./(\.git|node_modules|\.astro|\.vercel)(/|$)' \
  > "$outdir/dir-sizes.txt"

# 4) Clean tree of files/dirs (excludes heavy/ephemeral dirs)
find . \
  -type d \( -name .git -o -name node_modules -o -name .astro -o -name .vercel \) -prune -o \
  -print \
  | sed 's|^\./||' \
  | sort \
  > "$outdir/tree.txt"

echo "Repo report generated in $outdir:"
ls -1 "$outdir"
