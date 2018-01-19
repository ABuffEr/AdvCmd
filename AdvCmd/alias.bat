@echo off
:: Set or remove an alias, checking if it's already present
set arg=%*
if no%1 == no goto help
for /f "usebackq tokens=1,2* delims= " %%1 in ('%arg%') do (
 set action=%%1
 set alias=%%2
 set def=%%~3
)
if not %action% == remove if not %action% == add if not %action% == list goto :help
if %action% == list goto :list
if no%alias% == no goto :help
if not no"%def%" == no (
 set arg=%alias%=%def%
) else (
 set arg=%alias%=
)
find /i "%arg%" %~dp0alias-db.txt>nul 2>nul
if %errorlevel% == 0 (
 if %action% == add echo Alias %arg% already present. & goto :eof
 if %action% == remove goto :remove
) else (
 if %action% == remove echo Alias not found, nothing to do. & goto :eof
 if %action% == add if "%arg%" == "%alias%=" goto :help
)
find /i "%alias%=" %~dp0alias-db.txt>nul 2>nul
if %errorlevel% == 0 echo Updating %alias% & goto :remove

:add
echo %arg%>>%~dp0alias-db.txt
echo Added new alias %arg%
goto :eof

:remove
type %~dp0alias-db.txt | findstr /b /v /i "%alias%=" >> %~dp0alias-db-new.txt
del /q %~dp0alias-db.txt
ren %~dp0alias-db-new.txt alias-db.txt
if not %action% == add echo Removed alias for %alias%
if %action% == add (goto :add) else (goto :eof)

:list
echo Current aliases:
type %~dp0alias-db.txt
goto :eof

:help
echo Invalid arguments.
echo USAGE: alias list^|remove^|add ^<alias^> [^<command^>]
echo Where:
echo  - list (without arguments) shows all available aliases;
echo  - add or remove is the operation (add again an alias to update);
echo  - ^<alias^> is the chosen alias (without spaces);
echo  - ^<command^> (add only) is the command and switches for the alias (use quotation marks if with spaces).
echo.
echo EXAMPLES:
echo  alias add clone "git clone"
echo   (git must be in PATH)
echo  alias add cygwin C:\cygwin64\Cygwin.bat
echo  alias add cygwin C:\cygwin\Cygwin.bat
echo   (definition changed, so update previous alias)
echo  alias remove clone
echo  alias add dir "dir /b /o:g"
echo  alias add favFolder "explorer C:\Users\user\Documents\favoriteFolder"
echo  alias add uni "explorer "C:\path_with_spaces\University""
echo.
echo NOTES:
echo  1) restart Advanced Prompt to have new alias.
echo  2) alias is defined by doskey macros, adding $* (for other args) to specified command.
echo  3) BE AWARE with alias whose definition contains ^| or ^&.
echo     You must write them as ^^^^^^^| and ^^^^^^^&,
echo     or as normal if you edit directly alias-db.txt file.
