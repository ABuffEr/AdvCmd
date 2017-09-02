@echo off
curl --version>nul 2>nul
if not %errorlevel% == 0 (
 echo curl.exe required.
 echo Run get-utils or download it by yourself.
 goto :eof
)
curl ipecho.net/plain
