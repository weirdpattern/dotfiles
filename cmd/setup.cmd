@echo off

REM Check if folder already exists
IF NOT EXIST "%USERPROFILE%\.cmd\" (
  REM Create the .cmd folder  
  echo "Creating .cmd folder"
  mkdir "%USERPROFILE%\.cmd" 2>nul
  attrib +h "%USERPROFILE%\.cmd" /s /d
)

REM Copy the corresponding files
echo Copying autorun.bat
copy "%~dp0autorun.bat" "%USERPROFILE%\.cmd\autorun.bat" /-y

echo Copying .aliases
copy "%~dp0.aliases" "%USERPROFILE%\.cmd\.aliases" /-y

REM Sets the autorun.cmd as the default autorun action for the command processor
echo Registering autorun file
reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Command Processor" /v "Autorun" /d "%USERPROFILE%\.cmd\autorun.bat"