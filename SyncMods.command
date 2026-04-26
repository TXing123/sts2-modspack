#!/bin/bash
set -e

REPO_URL="https://github.com/TXing123/sts2-modspack.git"
INSTALL_DIR="$HOME/STS2-Modpack"
GAME_MODS_DIR="$HOME/Library/Application Support/Steam/steamapps/common/Slay the Spire 2/SlayTheSpire2.app/Contents/MacOS/mods"

echo "==> STS2 Modpack Installer / Sync"
echo

if ! command -v git >/dev/null 2>&1; then
  echo "ERROR: git is not installed."
  echo
  echo "Please install Xcode Command Line Tools first:"
  echo "xcode-select --install"
  echo
  read -p "Press Enter to exit..."
  exit 1
fi

if [ ! -d "$GAME_MODS_DIR" ]; then
  echo "Game mods folder not found."
  echo "Creating it now:"
  echo "$GAME_MODS_DIR"
  mkdir -p "$GAME_MODS_DIR"
fi

echo "==> Local modpack folder:"
echo "$INSTALL_DIR"
echo

if [ ! -d "$INSTALL_DIR/.git" ]; then
  echo "==> Cloning modpack repo..."
  rm -rf "$INSTALL_DIR"
  git clone "$REPO_URL" "$INSTALL_DIR"
else
  echo "==> Updating existing modpack repo..."
  cd "$INSTALL_DIR"
  git pull --ff-only
fi

if [ ! -d "$INSTALL_DIR/mods" ]; then
  echo "ERROR: mods folder not found in repo."
  echo "Expected:"
  echo "$INSTALL_DIR/mods"
  read -p "Press Enter to exit..."
  exit 1
fi

echo
echo "==> Clearing old game mods..."
find "$GAME_MODS_DIR" -mindepth 1 -maxdepth 1 -exec rm -rf {} +

echo
echo "==> Copying latest mods..."
rsync -a "$INSTALL_DIR/mods/" "$GAME_MODS_DIR/"

echo
echo "==> Done. Mods synced successfully."
echo
echo "Installed from:"
echo "$REPO_URL"
echo
echo "Game mods folder:"
echo "$GAME_MODS_DIR"
echo

read -p "Press Enter to exit..."