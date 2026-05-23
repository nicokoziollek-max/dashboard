#!/bin/bash
# Einmalig ausführen, um alle Abhängigkeiten zu installieren.
set -e

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo ""
echo "  Setup: Nico's Project Hub"
echo ""

# ── SenfTest Backend ──────────────────────────────────────────────────────────
echo "  [1/3] SenfTest Backend (Python 3.11)..."
VENV="$ROOT/senftest/backend/venv"
if [ ! -d "$VENV" ]; then
  python3.11 -m venv "$VENV"
fi
source "$VENV/bin/activate"
pip install -q -r "$ROOT/senftest/backend/requirements.txt"
playwright install chromium --quiet 2>/dev/null || true
deactivate

# ── SenfTest Frontend ─────────────────────────────────────────────────────────
echo "  [2/3] SenfTest Frontend (Node.js)..."
cd "$ROOT/senftest/frontend"
npm install --silent

# ── Secrets ───────────────────────────────────────────────────────────────────
echo "  [3/3] Secrets..."
if [ ! -f "$ROOT/senftest/.env" ]; then
  cp "$ROOT/senftest/.env.example" "$ROOT/senftest/.env"
  echo ""
  echo "  ⚠️  senftest/.env angelegt — bitte TELEGRAM_TOKEN und TELEGRAM_CHAT_ID eintragen!"
  echo ""
else
  echo "  ✅ senftest/.env vorhanden"
fi

echo ""
echo "  ✅ Setup abgeschlossen!"
echo ""
echo "  Starten:"
echo "    SenfTest:     bash senftest/start.sh"
echo "    NicoDash:     npx serve -l 4000 nicodash/"
echo "    Müllers Dach: node muellers-dach/server.js"
echo ""
