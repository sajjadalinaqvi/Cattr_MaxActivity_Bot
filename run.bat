@echo off
REM ========================================
REM Fresh Run Script for Space Bot
REM Clears all cache and runs the script
REM ========================================

echo.
echo ====================================
echo   Space Bot - Fresh Run
echo ====================================
echo.

REM Navigate to script directory
cd /d "%~dp0"

echo [1/5] Closing any running Python processes...
taskkill /F /IM python.exe 2>nul
taskkill /F /IM pythonw.exe 2>nul
timeout /t 2 /nobreak >nul
echo   - All Python processes closed

echo [2/5] Cleaning Python cache (AGGRESSIVE)...
if exist __pycache__ rmdir /s /q __pycache__ 2>nul
del /f /q *.pyc 2>nul
del /f /q *.pyo 2>nul
for /d %%d in (*) do (
    if exist "%%d\__pycache__" rmdir /s /q "%%d\__pycache__" 2>nul
)
echo   - All cache files cleaned

echo [3/5] Verifying bot.py exists...
if not exist bot.py (
    echo ERROR: bot.py not found!
    pause
    exit /b 1
)
echo   - bot.py found

echo [4/5] Recompiling Python bytecode...
python -m py_compile bot.py 2>nul
if errorlevel 1 (
    echo   - WARNING: Compilation had issues
) else (
    echo   - Compilation successful
)

echo [5/5] Starting Space Bot (FRESH VERSION)...
echo.
echo ====================================
echo   Press F6 to START the bot
echo   Press F8 to STOP the bot
echo   Press F9 to hide UI
echo ====================================
echo.
echo Starting in 2 seconds...
timeout /t 2 /nobreak >nul

python bot.py

if errorlevel 1 (
    echo.
    echo ====================================
    echo   ERROR: Script crashed!
    echo ====================================
    pause
)
