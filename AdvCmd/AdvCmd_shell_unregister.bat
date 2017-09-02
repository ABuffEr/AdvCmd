@echo off
net session>nul 2>&1
if not %errorlevel% == 0 (
 echo No admin rights, try again!
 pause
 goto :eof
)
reg delete HKEY_CLASSES_ROOT\*\shell\AdvCmd /f>nul 2>&1
reg delete HKEY_CLASSES_ROOT\Folder\shell\AdvCmd /f>nul 2>&1
reg delete HKEY_CLASSES_ROOT\Directory\shell\AdvCmd /f>nul 2>&1
reg delete HKEY_CLASSES_ROOT\Directory\Background\shell\AdvCmd /f>nul 2>&1
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\AdvCmd.exe" /f>nul 2>&1
echo AdvCmd shell integration removed successfully!
pause