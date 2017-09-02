@echo off
if noarg%* == noarg (
 echo Utility to hide the execution of batch script files.
 echo Usage: HideBatch path_to_file
 goto :eof
)
echo Hidden batch launcher generator
echo.
echo Processing %1...
echo Set WinScriptHost = CreateObject(WScript.Shell)>"%~dpn1.vbs"
echo WinScriptHost.Run Chr(34) ^& %~nx1 ^& Chr(34), 0 >>"%~dpn1.vbs"
echo Set WinScriptHost = Nothing>>"%~dpn1.vbs"
echo Done! Generated %~dpn1.vbs
