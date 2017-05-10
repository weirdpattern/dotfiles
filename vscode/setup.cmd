@echo off

REM Check if folder exists
IF EXIST "%APPDATA%\Code\User\" (      
  REM Copy the corresponding files
  echo Copying settings.json
  copy "%~dp0settings-win.json" "%APPDATA%\Code\User\settings.json" /-y
)
