####################################################################
# Overrides settings in profile.ps1 like aliases, functions, etc #
####################################################################

# Notepad++ as default editor
if (Test-Path "${env:programfiles}\Vim\vim80\vim.exe") {
  [Environment]::SetEnvironmentVariable("EDITOR", "${env:programfiles}\Vim\vim80\vim.exe")
} elseif (Test-Path "${env:programfiles(x86)}\Vim\vim80\vim.exe") {
  [Environment]::SetEnvironmentVariable("EDITOR", "${env:programfiles(x86)}\Vim\vim80\vim.exe")
} elseif (Test-Path "${env:programfiles}\Notepad++\notepad++.exe") {
  [Environment]::SetEnvironmentVariable("EDITOR", "$env:programfiles\Notepad++\notepad++.exe")
} elseif (Test-Path "${env:programfiles(x86)}\Notepad++\notepad++.exe") {
  [Environment]::SetEnvironmentVariable("EDITOR", "${env:programfiles(x86)}\Notepad++\notepad++.exe")
} else {
  [Environment]::SetEnvironmentVariable("EDITOR", "${env:windir}\System32\notepad.exe")
}

# user repositories
[Environment]::SetEnvironmentVariable("Sandbox", "C:\Sandbox");

# user information
[Environment]::SetEnvironmentVariable("GitUserName", "weirdpattern");
[Environment]::SetEnvironmentVariable("GitUserEmail", "patricio@weirdpattern.com");
