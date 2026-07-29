#!/usr/bin/env bash
# apply-l10n.sh — Sync upstream + convert skills to Traditional Chinese (Hong Kong)
#
# Only converts skills/ and CLAUDE.md (controls AI output language).
# Existing reports in reports/ are left untouched.
#
# Usage:
#   ./scripts/apply-l10n.sh          # full sync + apply
#   ./scripts/apply-l10n.sh --dry-run  # preview only

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
TRANSLATIONS="$REPO_ROOT/translations"
DRY_RUN=false

if [ "${1:-}" = "--dry-run" ]; then
  DRY_RUN=true
  echo "[dry-run mode]"
fi

# ── Step 1: Fetch upstream ───────────────────────────────────────────────────
echo "=== Fetching upstream ==="
git -C "$REPO_ROOT" fetch upstream

UPSTREAM_COMMIT="$(git -C "$REPO_ROOT" rev-parse upstream/main)"
CURRENT_COMMIT="$(git -C "$REPO_ROOT" rev-parse HEAD)"

if [ "$UPSTREAM_COMMIT" != "$CURRENT_COMMIT" ]; then
  if [ "$DRY_RUN" = false ]; then
    if ! git -C "$REPO_ROOT" diff --quiet HEAD 2>/dev/null; then
      echo "Stashing uncommitted changes..."
      git -C "$REPO_ROOT" stash push -m "l10n-pre-sync"
    fi
    git -C "$REPO_ROOT" checkout main 2>/dev/null || true
    git -C "$REPO_ROOT" reset --hard upstream/main
  fi
else
  echo "Already up-to-date."
fi

# ── Step 2: Convert skills + CLAUDE.md to Traditional Chinese ────────────────
echo ""
echo "=== Converting skills + CLAUDE.md (s2t) ==="

if [ "$DRY_RUN" = true ]; then
  find "$REPO_ROOT/skills" -name '*.md' | while read -r f; do echo "  [would convert] $f"; done
  echo "  [would convert] $REPO_ROOT/CLAUDE.md"
else
  find "$REPO_ROOT/skills" -name '*.md' -print0 "$REPO_ROOT/CLAUDE.md" | \
  python3 -c "
import opencc, sys
converter = opencc.OpenCC('s2t')
count = 0
for line in sys.stdin:
    fp = line.strip()
    if not fp: continue
    with open(fp, 'r', encoding='utf-8') as f:
        content = f.read()
    result = converter.convert(content)
    if result != content:
        with open(fp, 'w', encoding='utf-8') as f:
            f.write(result)
        count += 1
print(f'  Converted {count} file(s)')
"
fi

# ── Step 3: Apply translations/ overlay ──────────────────────────────────────
echo ""
echo "=== Applying translations/ overlay ==="

if [ ! -d "$TRANSLATIONS" ]; then
  echo "  No translations/ directory."
else
  OVERLAY=0
  while IFS= read -r -d '' trans_file; do
    rel_path="${trans_file#$TRANSLATIONS/}"
    [ "$rel_path" = "README.md" ] && continue
    target="$REPO_ROOT/$rel_path"
    if [ "$DRY_RUN" = true ]; then
      echo "  [would overlay] $rel_path"
    else
      mkdir -p "$(dirname "$target")"
      cp -- "$trans_file" "$target"
      echo "  [overlaid] $rel_path"
    fi
    OVERLAY=$((OVERLAY + 1))
  done < <(find "$TRANSLATIONS" -type f -print0)
  [ "$OVERLAY" -eq 0 ] && echo "  No overlay files."
fi

# ── Step 4: Commit ───────────────────────────────────────────────────────────
if [ "$DRY_RUN" = false ]; then
  echo ""
  echo "=== Committing ==="
  git -C "$REPO_ROOT" add -A
  if git -C "$REPO_ROOT" diff --cached --quiet; then
    echo "  No changes."
  else
    git -C "$REPO_ROOT" commit -m "l10n: sync upstream + Traditional Chinese skills"
    echo "  Done."
  fi
fi
