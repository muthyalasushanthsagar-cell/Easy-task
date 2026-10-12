@echo off
title Easy Task - React Frontend
echo ===================================================
echo Starting Easy Task React Frontend on Port 5173
echo ===================================================

cd /d "%~dp0frontend"

call npm.cmd run dev

pause
