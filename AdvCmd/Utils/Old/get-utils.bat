@echo off
title Utility downloader
echo.
echo Now you can get some useful utilities
echo (available only in Advanced Prompt)
echo Utilities available are:
echo - Wget: to download files from CLI in a powerful way;
echo - CopyPath: to copy paths from context menu;
echo - Junction: to manage directory junction points on NTFS;
echo - Ahk2Exe: to compile AutoHotkey scripts such as that included for pasting.
echo.
set workingDir=%tmp%\AdvCmd
wget --version>NUL 2>NUL
if %errorlevel% == 0 (
 set prg=wget -q -c -P %workingDir%
 set skipWget=1
 goto loop-download
)
if exist %systemroot%\system32\bitsadmin.exe (
 set prg=call :bitsget
 set skipWget=0
 goto loop-download
) else (
 echo ERROR: download not possible,
 echo bitsadmin.exe not supported and wget.exe absent from PATH/not installed.
 echo Please install Wget from:
 echo https://eternallybored.org/misc/wget/
 pause
 goto :eof
)

:bitsget
bitsadmin /transfer %~nx1 /download /priority high %1 %workingDir%\%~nx1 >NUL
goto :eof

:loop-download
md %workingDir%>NUL 2>NUL
for /f "tokens=1,2" %%a in (%~dp0get-utils-URLs.txt) do call :download %%a %%b
goto extract

:download
if %1 == Wget if %skipWget% == 1 goto :eof
set link=%2
if %1 == SQLite-Tools for /f "tokens=4 delims='" %%a in ('%prg% https://sqlite.org/download.html ^& find "d391('a9'," %workingDir%\download.html') do (set link=%2%%a)
set /p ans=Download %1? y/n: 
if %ans% == y (
 echo Download %1...
 %prg% %link%
)
goto :eof

:extract
if exist %workingDir%\wget-*.zip ren %workingDir%\wget-*.zip Wget.zip
if exist %workingDir%\ahk2exe.zip ren %workingDir%\ahk2exe.zip Ahk2Exe.zip
if exist %workingDir%\sqlite-tools-*.zip ren %workingDir%\sqlite-tools-*.zip SQLite-Tools.zip
for %%a in (%workingDir%\*.zip) do (
 echo Extracting %%~na...
 if %%~na == SQLite-Tools (
  %~dp0Utils\7Zip\7za e -aoa -bd -bso0 -y -o%~dp0Utils\%%~na %%a *.* -r
 ) else (
  %~dp0Utils\7Zip\7za x -aoa -bd -bso0 -y -o%~dp0Utils\%%~na %%a
 )
 if %%~na == Wget call %~dp0alias.bat add wget %~dp0Utils\Wget\wget.exe>NUL
 if %%~na == Junction call %~dp0alias.bat add junction "%~dp0Utils\Junction\junction.exe -nobanner -accepteula">NUL
)
if exist %workingDir%\*.zip (echo Done! Extracted in AdvCmd\Utils directory.) else (echo Nothing to extract.)
rd /s /q %workingDir%
pause
