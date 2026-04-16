#!/bin/bash
set -e

echo ""
echo "╔══════════════════════════════════════════════╗"
echo "║       Claude Code CLI Playground 🤖           ║"
echo "╚══════════════════════════════════════════════╝"
echo ""

# Check for API key (only needed if using API/Console auth instead of Claude subscription)
if [ -z "$ANTHROPIC_API_KEY" ]; then
  echo "ℹ️  No ANTHROPIC_API_KEY set."
  echo "   If you have a Claude Pro/Max/Team subscription, run 'claude' and log in via browser."
  echo "   If you use API access, set it in your .env file before starting."
  echo ""
else
  echo "✅ ANTHROPIC_API_KEY detected (Console/API access)."
  echo ""
fi

echo "📦 Claude Code: $(claude --version 2>/dev/null || echo 'not found — check PATH')"
echo "📁 Workspace:   /workspace"
echo ""
echo "To get started:"
echo "  claude          → start an interactive session"
echo "  claude --help   → see all options"
echo "  /login          → switch accounts inside Claude Code"
echo ""

exec "$@"
