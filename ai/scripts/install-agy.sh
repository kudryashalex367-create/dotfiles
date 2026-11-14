#!/usr/bin/env bash
# Устанавливает конфиги AGY (Antigravity CLI) из dotfiles
# Вызывается вручную или из install.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
AGY_CONFIG="$HOME/.gemini/config"
AGY_SOURCE="$(dirname "$SCRIPT_DIR")/.gemini/config"

echo "→ AGY config: $AGY_SOURCE → $AGY_CONFIG"

# AGENTS.md
ln -sf "$AGY_SOURCE/AGENTS.md" "$AGY_CONFIG/AGENTS.md"
echo "  ✓ AGENTS.md"

# hooks.json
ln -sf "$AGY_SOURCE/hooks.json" "$AGY_CONFIG/hooks.json"
echo "  ✓ hooks.json"

# hooks/security-guard.sh
mkdir -p "$AGY_CONFIG/hooks"
ln -sf "$AGY_SOURCE/hooks/security-guard.sh" "$AGY_CONFIG/hooks/security-guard.sh"
chmod +x "$AGY_SOURCE/hooks/security-guard.sh"
echo "  ✓ hooks/security-guard.sh"

echo "→ Готово."
