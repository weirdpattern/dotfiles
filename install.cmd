@echo off

REM Validate the command was executed in admin mode
net session >nul 2>&1
if %errorLevel% EQU 0 (
  goto setup  
) else (
  echo "To setup the environment you need to run the command in admin mode"
  exit /B 1
)

:setup
  REM Setups to be run after installation
  set setups=("%~dp0cmd\setup.cmd" "%~dp0vscode\setup.cmd" "%~dp0powershell\setup.cmd")

  REM Run setup files
  for %%i in %setups% do call "%%~i"