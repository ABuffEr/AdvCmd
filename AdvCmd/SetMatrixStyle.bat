@echo off
net session>nul 2>&1
if not %errorlevel% == 0 (
 echo No admin rights, try again!
 pause
 goto :eof
)
if exist %~dp0AdvCmd.exe (
 call :add %~dp0
) else (
 echo AdvCmd.exe not found, please read instructions again!
 pause
)
goto :eof

:add
set regpath=%1
set regpath=%regpath:\=_%
set key=HKEY_CURRENT_USER\Console\%regpath%AdvCmd.exe
reg add %key% /v CurrentPage /t REG_DWORD /d 0 /f>nul 2>&1
reg add %key% /v HistoryNoDup /t REG_DWORD /d 1 /f>nul 2>&1
reg add %key% /v FullScreen /t REG_DWORD /d 1 /f>nul 2>&1
reg add %key% /v ScreenColors /t REG_DWORD /d 7 /f>nul 2>&1
reg add %key% /v PopupColors /t REG_DWORD /d 0x000000f5 /f>nul 2>&1
reg add %key% /v ColorTable00 /t REG_DWORD /d 0 /f>nul 2>&1
reg add %key% /v ColorTable01 /t REG_DWORD /d 0x00800000 /f>nul 2>&1
reg add %key% /v ColorTable02 /t REG_DWORD /d 0x00008000 /f>nul 2>&1
reg add %key% /v ColorTable03 /t REG_DWORD /d 0x00808000 /f>nul 2>&1
reg add %key% /v ColorTable04 /t REG_DWORD /d 0x00000080 /f>nul 2>&1
reg add %key% /v ColorTable05 /t REG_DWORD /d 0x003fa33f /f>nul 2>&1
reg add %key% /v ColorTable06 /t REG_DWORD /d 0x00008080 /f>nul 2>&1
reg add %key% /v ColorTable07 /t REG_DWORD /d 0x003fa33f /f>nul 2>&1
reg add %key% /v ColorTable08 /t REG_DWORD /d 0x00808080 /f>nul 2>&1
reg add %key% /v ColorTable09 /t REG_DWORD /d 0x00ff0000 /f>nul 2>&1
reg add %key% /v ColorTable10 /t REG_DWORD /d 0x0000ff00 /f>nul 2>&1
reg add %key% /v ColorTable11 /t REG_DWORD /d 0x00ffff00 /f>nul 2>&1
reg add %key% /v ColorTable12 /t REG_DWORD /d 0x000000ff /f>nul 2>&1
reg add %key% /v ColorTable13 /t REG_DWORD /d 0x00ff00ff /f>nul 2>&1
reg add %key% /v ColorTable14 /t REG_DWORD /d 0x0000ffff /f>nul 2>&1
reg add %key% /v ColorTable15 /t REG_DWORD /d 0x00ffffff /f>nul 2>&1
echo Matrix style set successfully!
pause
