@echo off

REM Copy the corresponding files
echo Copying .gitconfig
copy "%~dp0.gitconfig" "%USERPROFILE%\.gitconfig" /-y

echo Copying .gitoverrides
copy "%~dp0.gitoverride_win" "%USERPROFILE%\.gitoverride" /-y