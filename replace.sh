#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
TARGET_DIR="$HOME/Library/Application Support/Steam/steamapps/common/Slay the Spire 2/SlayTheSpire2.app/Contents/MacOS/mods"

echo "==> Script dir: $SCRIPT_DIR"
echo "==> Target dir: $TARGET_DIR"

[ -d "$TARGET_DIR" ] || { echo "❌ Target not found: $TARGET_DIR"; exit 1; }

echo "==> Syncing all sibling contents (clean replace)..."
rsync -a --delete \
  --exclude "$(basename "$0")" \
  --exclude ".DS_Store" \
  "$SCRIPT_DIR"/ "$TARGET_DIR"/

echo "✅ All done."