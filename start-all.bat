@echo off
title Easy Task Launcher
echo ===================================================
echo Launching Easy Task Full-Stack Application...
echo Backend:  http://localhost:8088
echo Frontend: http://localhost:5173
echo ===================================================

start "Easy Task Backend" cmd /c "%~dp0start-backend.bat"
timeout /t 3 /nobreak > nul
start "Easy Task Frontend" cmd /c "%~dp0start-frontend.bat"

echo.
echo Both services have been launched in separate windows!
echo Open your browser at: http://localhost:5173
echo.
pause
