@echo off
echo.>nul 2>choco-packages.txt
for /f "usebackq skip=1 tokens=1,2 delims=. " %%a in (`choco list -lo`) do (
 if not %%b == install (
  if not %%b == portable (
   if not %%b == packages (
    echo %%a>>choco-packages.txt
   )
  )
 )
)