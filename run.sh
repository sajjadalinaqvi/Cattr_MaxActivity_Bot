#!/usr/bin/env bash
# ==============================================================================
# Space Bot Pro - Linux Launch Script
# Checks Python & .venv, installs dependencies if needed, and launches bot.py
# ==============================================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

echo ""
echo "===================================="
echo "   Space Bot Pro - Linux Launcher"
echo "===================================="
echo ""

# 1. Check if virtual environment (.venv) is already available and functional
if [ -d ".venv" ] && [ -f ".venv/bin/activate" ] && .venv/bin/python -c "import sys" 2>/dev/null; then
    echo "[1/3] Virtual environment (.venv) found."
    echo "[*] Directly activating and running..."
    # shellcheck disable=SC1091
    source .venv/bin/activate
else
    echo "[1/3] Virtual environment (.venv) not found."
    echo "[*] Checking Python availability..."

    PYTHON_CMD=""
    if command -v python3 >/dev/null 2>&1 && python3 -c "import sys" 2>/dev/null; then
        PYTHON_CMD="python3"
    elif command -v python >/dev/null 2>&1 && python -c "import sys" 2>/dev/null; then
        PYTHON_CMD="python"
    fi

    # If Python is not available, download/install Python
    if [ -z "$PYTHON_CMD" ]; then
        echo "[!] Python is not installed on this system."
        echo "[*] Attempting to download/install Python..."

        SUDO_PREFIX=""
        if [ "$EUID" -ne 0 ] && command -v sudo >/dev/null 2>&1; then
            SUDO_PREFIX="sudo"
        fi

        if command -v apt-get >/dev/null 2>&1; then
            echo "  - Installing Python via apt..."
            $SUDO_PREFIX apt-get update && $SUDO_PREFIX apt-get install -y python3 python3-venv python3-pip python3-tk
        elif command -v dnf >/dev/null 2>&1; then
            echo "  - Installing Python via dnf..."
            $SUDO_PREFIX dnf install -y python3 python3-pip python3-tkinter
        elif command -v yum >/dev/null 2>&1; then
            echo "  - Installing Python via yum..."
            $SUDO_PREFIX yum install -y python3 python3-pip
        elif command -v pacman >/dev/null 2>&1; then
            echo "  - Installing Python via pacman..."
            $SUDO_PREFIX pacman -Sy --noconfirm python python-pip tk
        elif command -v zypper >/dev/null 2>&1; then
            echo "  - Installing Python via zypper..."
            $SUDO_PREFIX zypper install -y python3 python3-pip python3-tk
        elif command -v apk >/dev/null 2>&1; then
            echo "  - Installing Python via apk..."
            $SUDO_PREFIX apk add --no-cache python3 py3-pip python3-tkinter
        else
            echo "  - No system package manager detected. Attempting standalone Python download..."
            ARCH="$(uname -m)"
            if [ "$ARCH" = "x86_64" ]; then
                STANDALONE_URL="https://github.com/indygreg/python-build-standalone/releases/download/20240415/cpython-3.11.9+20240415-x86_64-unknown-linux-gnu-install_only.tar.gz"
                mkdir -p "$HOME/.local/python311"
                curl -sSL "$STANDALONE_URL" | tar -xz -C "$HOME/.local/python311" --strip-components=1
                export PATH="$HOME/.local/python311/bin:$PATH"
            fi
        fi

        if command -v python3 >/dev/null 2>&1 && python3 -c "import sys" 2>/dev/null; then
            PYTHON_CMD="python3"
        elif command -v python >/dev/null 2>&1 && python -c "import sys" 2>/dev/null; then
            PYTHON_CMD="python"
        else
            echo "[ERROR] Failed to install Python automatically."
            echo "Please install Python 3 manually (e.g. sudo apt install -y python3 python3-venv python3-pip) and retry."
            exit 1
        fi
        echo "[*] Python installed successfully: $($PYTHON_CMD --version 2>&1)"
    fi

    # Create virtual environment (.venv)
    echo "[2/3] Creating virtual environment (.venv)..."
    if ! "$PYTHON_CMD" -m venv .venv 2>/dev/null; then
        # On Ubuntu/Debian, python3-venv package may need to be explicitly installed
        if command -v apt-get >/dev/null 2>&1; then
            echo "  - python3-venv required on Debian/Ubuntu. Installing..."
            SUDO_PREFIX=""
            if [ "$EUID" -ne 0 ] && command -v sudo >/dev/null 2>&1; then
                SUDO_PREFIX="sudo"
            fi
            $SUDO_PREFIX apt-get update && $SUDO_PREFIX apt-get install -y python3-venv python3-pip
        fi
        "$PYTHON_CMD" -m venv .venv
    fi

    echo "[*] Activating virtual environment..."
    # shellcheck disable=SC1091
    source .venv/bin/activate

    echo "[*] Installing dependencies from requirements.txt..."
    pip install --upgrade pip
    if [ -f "requirements.txt" ]; then
        pip install -r requirements.txt
    fi
fi

# 2. Clean cache
echo "[2/3] Cleaning Python cache files..."
find . -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true
find . -type f -name "*.pyc" -delete 2>/dev/null || true
find . -type f -name "*.pyo" -delete 2>/dev/null || true
echo "  - Cache cleaned."

# 3. Check GUI support & launch bot
echo "[3/3] Starting Space Bot Pro..."
HAS_TK=1
if ! python -c "import tkinter" 2>/dev/null; then
    HAS_TK=0
    echo ""
    echo "  [NOTE] 'tkinter' is not installed in Python."
    echo "  To enable the full graphical UI, run:"
    echo "      sudo apt install -y python3-tk"
    echo ""
    echo "  Starting in Terminal / CLI mode instead..."
    echo ""
fi

echo "===================================="
echo "  Start Hotkey : F6"
echo "  Stop Hotkey  : F8"
echo "  Toggle UI    : F9"
echo "  Hide Target  : F7"
echo "===================================="
echo ""

if [ "$HAS_TK" -eq 0 ]; then
    case " $* " in
        *" --cli "*|*" -c "*) exec python bot.py "$@" ;;
        *) exec python bot.py --cli "$@" ;;
    esac
else
    exec python bot.py "$@"
fi
