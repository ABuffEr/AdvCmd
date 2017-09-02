@echo off
net session>nul 2>&1
if not %errorlevel% == 0 (
 echo No admin rights, try again!
 pause
 goto :eof
)
if exist %~dp0AdvCmd.exe (
 reg add HKEY_CLASSES_ROOT\*\shell\AdvCmd /ve /t REG_SZ /d "A&dvanced Prompt here" /f>nul 2>&1
 reg add HKEY_CLASSES_ROOT\*\shell\AdvCmd\command /ve /t REG_SZ /d "\"%~dp0AdvCmd.exe\" \"%%1\"" /f>nul 2>&1

 reg add HKEY_CLASSES_ROOT\Folder\shell\AdvCmd /ve /t REG_SZ /d "A&dvanced Prompt here" /f>nul 2>&1
 reg add HKEY_CLASSES_ROOT\Folder\shell\AdvCmd\command /ve /t REG_SZ /d "\"%~dp0AdvCmd.exe\" \"%%1\"" /f>nul 2>&1

 reg add HKEY_CLASSES_ROOT\Directory\shell\AdvCmd /ve /t REG_SZ /d "A&dvanced Prompt here" /f>nul 2>&1
 reg add HKEY_CLASSES_ROOT\Directory\shell\AdvCmd\command /ve /t REG_SZ /d "\"%~dp0AdvCmd.exe\" \"%%1\"" /f>nul 2>&1

 reg add HKEY_CLASSES_ROOT\Directory\Background\shell\AdvCmd /ve /t REG_SZ /d "A&dvanced Prompt here" /f>nul 2>&1
 reg add HKEY_CLASSES_ROOT\Directory\Background\shell\AdvCmd\command /ve /t REG_SZ /d "\"%~dp0AdvCmd.exe\" \"%%W\"" /f>nul 2>&1

 reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\AdvCmd.exe" /ve /t REG_SZ /d "%~dp0AdvCmd.exe" /f>nul 2>&1

 echo AdvCmd shell integration added successfully!
 pause
) else (
 echo AdvCmd.exe not found, please read instructions again!
 pause
)