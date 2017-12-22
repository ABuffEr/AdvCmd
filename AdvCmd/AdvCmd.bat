@echo off
setlocal
:: rem next line to avoid colored prompt
call :checkColors %~dp0
if noarg%* == noarg (
 cls
 title Advanced Prompt - No target
 echo.
 :: A useless but funny decoration, Matrix style (see instructions for colors)
 echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
 echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
 echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
 echo.
 echo Hello, Neo.
 echo Matrix is ready.
 set cpath="%userprofile%"
 echo.
 :: cpath is set, but not shown, I don't understand, so...
 echo Current path ^(cpath^)^: "%cd%"
 goto launch
)
:: Group args (normally, only one)
set arg=%*
:: Replace & with ^&, marking as special char
set fixedPath=%arg:&=^&%
:: Get dir or file name (and extension)
for %%a in (%fixedPath%) do (set last="%%~nxa")
:: Remove useless double quotes
for %%a in (%last%) do (set fixedName=%%~a)
for %%a in (%fixedPath%) do (set fixedPath=%%~a)
title Advanced Prompt - %fixedName%
echo.
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo.
echo Hello, Neo.
echo Matrix is ready.
:: Get full filename and filename without extension
if not "%~n1" == "" (
 set f="%~nx1"
 set n="%~n1"
)
:: Check if exist and get extension
if not "%~x1" == "" set tempext=%~x1
if not "%tempext%" == "" set ext=%tempext:~1%
:: Get current path of selected file/dir
for %%a in (%arg%) do (set temppath=%%~dpa)
set cpath="%temppath:~0,-1%"
echo.
:: Show available variables
echo Starting variables:
echo file or dir (f): %f%
echo name (n): %n%
if not "%ext%" == "" echo ext: %ext%
echo current path (cpath): %cpath%

:launch:
:: Backup and extend current PATH system variable
set bakpath=%path%
set path=%path%;%~dp0;%~dp0Utils
:: Set alias for this session, see alias-db.txt
for /f "tokens=1,2 delims==" %%a in (%~dp0alias-db.txt) do (doskey %%a=%%b $*)
:: Set codepage to more flexible 1252 (usually default 850)
mode con cp select=1252>nul 2>&1
:: Start AutoHotkey script/exe for useful shortcuts
start /b %~dp0ShortcutsCommandPrompt.exe
:: Start a "short" prompt
start /b /max /w cmd.exe /v /k "prompt $G"
:: Manage closure of AutoHotkey script/exe, according to running instances of this prompt
set count=0
for /f "usebackq delims=" %%a in (`tasklist /nh /v /fi "imagename eq AdvCmd.exe" /fo csv`) do @(set /a count+=1)
if %count% lss 2 (taskkill /f /im ShortcutsCommandPrompt.exe>nul)
set path=%bakpath%
goto :eof

:checkColors
set regpath=%1
set regpath=%regpath:\=_%
reg query HKEY_CURRENT_USER\Console\%regpath%AdvCmd.exe>nul 2>&1
if %errorlevel% == 1 (color 02)
