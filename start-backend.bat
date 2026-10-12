@echo off
title Easy Task - Backend Server
echo ===================================================
echo Starting Easy Task Spring Boot Backend on Port 8088
echo ===================================================

cd /d "%~dp0backend"

REM Check for JAVA_HOME or STS JDK
if not defined JAVA_HOME (
    if exist "C:\sts-5.2.0.RELEASE\plugins\org.eclipse.justj.openjdk.hotspot.jre.full.win32.x86_64_25.0.3.v20260502-0818\jre" (
        set "JAVA_HOME=C:\sts-5.2.0.RELEASE\plugins\org.eclipse.justj.openjdk.hotspot.jre.full.win32.x86_64_25.0.3.v20260502-0818\jre"
    )
)

echo Using JAVA_HOME: %JAVA_HOME%
echo.

REM If target jar exists, run it directly for instant startup, else build and run
if exist "target\easy-task-backend-1.0.0.jar" (
    "%JAVA_HOME%\bin\java.exe" -jar target\easy-task-backend-1.0.0.jar
) else (
    call mvnw.cmd spring-boot:run
)

pause
