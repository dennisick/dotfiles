#!/usr/bin/env bash
# Symlink dotfiles into $HOME. Existing files are moved to <name>.bak.<timestamp>.
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
STAMP="$(date +%Y%m%d%H%M%S)"

# repo path -> target path
declare -A LINKS=(
  [.wezterm.lua]="$HOME/.wezterm.lua"
  [AGENTS.md]="$HOME/AGENTS.md"
  [nvim]="$HOME/.config/nvim"
)

for src in "${!LINKS[@]}"; do
  target="${LINKS[$src]}"
  src="$DOTFILES/$src"

  if [ "$(readlink "$target" 2>/dev/null)" = "$src" ]; then
    echo "ok       $target"
    continue
  fi

  mkdir -p "$(dirname "$target")"
  if [ -e "$target" ] || [ -L "$target" ]; then
    mv "$target" "$target.bak.$STAMP"
    echo "backup   $target -> $target.bak.$STAMP"
  fi

  ln -s "$src" "$target"
  echo "linked   $target -> $src"
done
