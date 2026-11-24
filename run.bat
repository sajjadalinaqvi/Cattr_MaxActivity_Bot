@echo off
REM ==============================================================================
REM Space Bot Pro - Windows Launch Script
REM Checks Python & .venv, installs dependencies if needed, and launches bot.py
REM ==============================================================================

REM Navigate to script directory
cd /d "%~dp0"

echo.
echo ====================================
echo   Space Bot Pro - Windows Launcher
echo ====================================
echo.

REM 1. If .venv is already available and working, directly activate and run
if exist ".venv\Scripts\activate.bat" (
    if exist ".venv\Scripts\python.exe" (
        echo [1/3] Virtual environment (.venv) found.
        echo [*] Directly activating and running...
        call .venv\Scripts\activate.bat
        goto RUN_BOT
    )
)

REM 2. If .venv not available, check if Python is available
echo [1/3] Virtual environment (.venv) not found.
echo [*] Checking Python availability...

set "PY_CMD="

REM Check 'python' command
python -c "import sys" >nul 2>&1
if not errorlevel 1 (
    set "PY_CMD=python"
    goto CREATE_VENV
)

REM Check Python launcher 'py'
py -c "import sys" >nul 2>&1
if not errorlevel 1 (
    set "PY_CMD=py"
    goto CREATE_VENV
)

REM If neither is available, download and install Python automatically
echo [!] Python is not available on this system.
echo [*] Downloading Python installer...

set "PY_INSTALLER=%TEMP%\python_installer.exe"
set "PY_URL=https://www.python.org/ftp/python/3.11.9/python-3.11.9-amd64.exe"
if "%PROCESSOR_ARCHITECTURE%"=="x86" (
    if not defined PROCESSOR_ARCHITEW6432 (
        set "PY_URL=https://www.python.org/ftp/python/3.11.9/python-3.11.9.exe"
    )
)

REM Try curl first, fallback to PowerShell
where curl >nul 2>&1
if not errorlevel 1 (
    curl -fSL -o "%PY_INSTALLER%" "%PY_URL%"
) else (
    powershell -ExecutionPolicy Bypass -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; (New-Object System.Net.WebClient).DownloadFile('%PY_URL%', '%PY_INSTALLER%')"
)

if not exist "%PY_INSTALLER%" goto INSTALL_FAILED
for %%I in ("%PY_INSTALLER%") do if %%~zI equ 0 (
    del /f /q "%PY_INSTALLER%" 2>nul
    goto INSTALL_FAILED
)

echo [*] Installing Python (silent mode, adding to PATH)...
"%PY_INSTALLER%" /quiet InstallAllUsers=0 PrependPath=1 Include_pip=1 Include_test=0
del /f /q "%PY_INSTALLER%" 2>nul

REM Refresh PATH from Registry for this session
for /f "tokens=2*" %%a in ('reg query "HKCU\Environment" /v Path 2^>nul') do set "PATH=%%b;%PATH%"
for /f "tokens=2*" %%a in ('reg query "HKLM\System\CurrentControlSet\Control\Session Manager\Environment" /v Path 2^>nul') do set "PATH=%%b;%PATH%"

REM Also add standard per-user Python installation path if present
if exist "%LOCALAPPDATA%\Programs\Python\Python311\python.exe" (
    set "PATH=%LOCALAPPDATA%\Programs\Python\Python311;%LOCALAPPDATA%\Programs\Python\Python311\Scripts;%PATH%"
    set "PY_CMD=%LOCALAPPDATA%\Programs\Python\Python311\python.exe"
)

python -c "import sys" >nul 2>&1
if not errorlevel 1 (
    set "PY_CMD=python"
)

if not defined PY_CMD goto INSTALL_FAILED
echo [*] Python installed successfully!

:CREATE_VENV
REM 3. Python is available: create .venv, install requirements, activate and run
echo [2/3] Creating virtual environment (.venv)...
"%PY_CMD%" -m venv .venv
if errorlevel 1 (
    echo [ERROR] Failed to create virtual environment (.venv)!
    pause
    exit /b 1
)

echo [*] Activating virtual environment...
call .venv\Scripts\activate.bat

echo [*] Installing dependencies from requirements.txt...
python -m pip install --upgrade pip
if exist requirements.txt (
    pip install -r requirements.txt
    if errorlevel 1 (
        echo [ERROR] Failed to install dependencies from requirements.txt!
        pause
        exit /b 1
    )
)

:RUN_BOT
REM 4. Clean cache and run bot
echo [3/3] Cleaning Python cache files...
taskkill /FI "WINDOWTITLE eq Space Bot*" /F /IM python.exe 2>nul
taskkill /F /IM pythonw.exe 2>nul
if exist __pycache__ rmdir /s /q __pycache__ 2>nul
del /f /q *.pyc 2>nul
del /f /q *.pyo 2>nul
for /d %%d in (*) do (
    if exist "%%d\__pycache__" rmdir /s /q "%%d\__pycache__" 2>nul
)

if not exist bot.py (
    echo [ERROR] bot.py not found!
    pause
    exit /b 1
)

echo.
echo ====================================
echo   Starting Space Bot Pro...
echo   Press F6 to START the bot
echo   Press F8 to STOP the bot
echo   Press F9 to hide UI
echo ====================================
echo.

python bot.py %*

if errorlevel 1 (
    echo.
    echo ====================================
    echo   ERROR: Script crashed!
    echo ====================================
    pause
)
exit /b 0

:INSTALL_FAILED
echo.
echo ======================================================================
echo [ERROR] Python could not be installed or verified automatically.
echo Please install Python manually from: https://www.python.org/downloads/
echo Make sure to check "Add Python to PATH" during installation.
echo ======================================================================
echo.
pause
exit /b 1
