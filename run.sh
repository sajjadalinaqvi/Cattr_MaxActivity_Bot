#!/usr/bin/env bash
# ==============================================================================
# Space Bot Pro - Linux Launch Script
# Cleans Python cache, verifies virtual environment, and runs bot.py
# ==============================================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

echo ""
echo "===================================="
echo "   Space Bot Pro - Linux Launcher"
echo "===================================="
echo ""

# 1. Detect and activate Python virtual environment
if [ -d ".venv" ]; then
    PYTHON_EXEC=".venv/bin/python"
    echo "[1/4] Using virtual environment: .venv"
elif [ -n "$VIRTUAL_ENV" ]; then
    PYTHON_EXEC="python"
    echo "[1/4] Using active virtual environment: $VIRTUAL_ENV"
else
    PYTHON_EXEC="python3"
    echo "[1/4] Virtual environment not found. Using system python3."
fi

# 2. Clean cache
echo "[2/4] Cleaning Python cache files..."
find . -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true
find . -type f -name "*.pyc" -delete 2>/dev/null || true
find . -type f -name "*.pyo" -delete 2>/dev/null || true
echo "  - Cache cleaned."

# 3. Check dependencies & Tkinter
echo "[3/4] Verifying Python environment and dependencies..."
if ! "$PYTHON_EXEC" -c "import pynput, Xlib" 2>/dev/null; then
    echo "  - Installing required packages (pynput, python-xlib)..."
    "$PYTHON_EXEC" -m pip install -r requirements.txt
fi

HAS_TK=1
if ! "$PYTHON_EXEC" -c "import tkinter" 2>/dev/null; then
    HAS_TK=0
    echo ""
    echo "  [NOTE] 'tkinter' is not installed in Python."
    echo "  To enable the full graphical UI, run:"
    echo "      sudo apt install -y python3-tk"
    echo ""
    echo "  Starting in Terminal / CLI mode instead..."
    echo ""
fi

# 4. Launch bot
echo "[4/4] Starting Space Bot Pro..."
echo "===================================="
echo "  Start Hotkey : F6"
echo "  Stop Hotkey  : F8"
echo "  Toggle UI    : F9"
echo "  Hide Target  : F7"
echo "===================================="
echo ""

if [ "$HAS_TK" -eq 0 ]; then
    exec "$PYTHON_EXEC" bot.py --cli "$@"
else
    exec "$PYTHON_EXEC" bot.py "$@"
fi
