# Easy Task PowerShell Launcher
Write-Host "===================================================" -ForegroundColor Cyan
Write-Host "Starting Easy Task Full-Stack Application..." -ForegroundColor Green
Write-Host "Backend API:  http://localhost:8088" -ForegroundColor Yellow
Write-Host "Frontend App: http://localhost:5173" -ForegroundColor Yellow
Write-Host "===================================================" -ForegroundColor Cyan

$scriptRoot = $PSScriptRoot
if (-not $scriptRoot) { $scriptRoot = Get-Location }

# Set JDK
$stsJdk = "C:\sts-5.2.0.RELEASE\plugins\org.eclipse.justj.openjdk.hotspot.jre.full.win32.x86_64_25.0.3.v20260502-0818\jre"
if (Test-Path $stsJdk) {
    $env:JAVA_HOME = $stsJdk
}

# Start Backend
Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd '$scriptRoot\backend'; `$env:JAVA_HOME='$env:JAVA_HOME'; & '`$env:JAVA_HOME\bin\java.exe' -jar 'target\easy-task-backend-1.0.0.jar'"

Start-Sleep -Seconds 3

# Start Frontend
Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd '$scriptRoot\frontend'; npm.cmd run dev"

Write-Host "`nServices started in separate terminal windows!" -ForegroundColor Green
Write-Host "Browser UI: http://localhost:5173" -ForegroundColor Cyan
Start-Process "http://localhost:5173"
