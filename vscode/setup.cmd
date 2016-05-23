@echo off

REM Check if folder exists
IF EXIST "%APPDATA%\Code\User\" (      
  REM Copy the corresponding files
  echo Copying settings.json
  copy "%~dp0settings.json" "%APPDATA%\Code\User\settings.json" /-y
)