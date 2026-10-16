#!/usr/bin/env bash
# Clone dotfiles to a temp dir, then copy them to $HOME, asking before each overwrite.
set -euo pipefail

REPO="https://github.com/zamhedonia/dotfiles.git"
tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

git clone --depth 1 "$REPO" "$tmp"
cd "$tmp"

while IFS= read -r -d '' f <&3; do
  rel="${f#./}"
  dest="$HOME/$rel"
  if [ -e "$dest" ]; then
    read -r -p "Overwrite $dest? [y/N] " ans </dev/tty
    [[ "$ans" =~ ^[Yy]$ ]] || { echo "Skipped $rel"; continue; }
  fi
  mkdir -p "$(dirname "$dest")"
  cp "$f" "$dest"
  echo "Copied $rel"
done 3< <(find . -path ./.git -prune -o -type f \
  ! -path ./README.md ! -path ./clone_to_home_no_overwrite.sh -print0)
