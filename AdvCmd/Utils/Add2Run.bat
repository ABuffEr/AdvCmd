@echo off
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\%1.exe" /ve /t REG_SZ /d %2 /f
echo %1 alias added.