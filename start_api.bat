@echo off
setlocal EnableExtensions
cd /d "%~dp0"

set "PORT=8000"
set "PY=.venv\Scripts\python.exe"

echo ========================================
echo Movie Library API - quick start
echo ========================================
echo.

if not exist "requirements.txt" (
    echo ERROR: requirements.txt was not found.
    echo Run this file from the movie_library folder.
    pause
    exit /b 1
)

where python >nul 2>nul
if errorlevel 1 (
    echo ERROR: Python was not found in PATH.
    echo Install Python 3.11 and enable "Add python.exe to PATH".
    pause
    exit /b 1
)

if not exist "%PY%" (
    echo [1/4] Creating virtual environment .venv...
    python -m venv .venv
    if errorlevel 1 (
        echo ERROR: Could not create virtual environment.
        pause
        exit /b 1
    )
) else (
    echo [1/4] Virtual environment already exists.
)

if not exist ".venv\.deps_installed" (
    echo [2/4] Installing dependencies. First launch may take a few minutes...
    "%PY%" -m pip install --upgrade pip
    if errorlevel 1 (
        echo ERROR: Could not upgrade pip.
        pause
        exit /b 1
    )

    "%PY%" -m pip install -r requirements.txt
    if errorlevel 1 (
        echo ERROR: Could not install dependencies.
        pause
        exit /b 1
    )

    echo ok> ".venv\.deps_installed"
) else (
    echo [2/4] Dependencies already installed.
)

echo [3/4] Loading demo data...
"%PY%" seed_data.py
if errorlevel 1 (
    echo ERROR: Could not run seed_data.py.
    pause
    exit /b 1
)

echo [4/4] Starting API server...
echo.
echo Open this URL in your browser:
echo http://127.0.0.1:%PORT%/docs
echo.
echo To stop the server, press Ctrl+C in this window.
echo.

start "" "http://127.0.0.1:%PORT%/docs"
"%PY%" -m uvicorn app.main:app --host 127.0.0.1 --port %PORT% --reload

echo.
echo Server stopped.
pause
