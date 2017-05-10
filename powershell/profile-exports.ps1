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

# dotnet environments
if (Test-Path "${env:ProgramFiles}\Microsoft SDKs\Windows\v7.0A\bin\NETFX 4.0 Tools\") {
  [Environment]::SetEnvironmentVariable("SDK40", "${env:ProgramFiles}\Microsoft SDKs\Windows\v7.0A\bin\NETFX 4.0 Tools\")
} elseif (Test-Path "${env:ProgramFiles(x86)}\Microsoft SDKs\Windows\v7.0A\bin\NETFX 4.0 Tools\") {
  [Environment]::SetEnvironmentVariable("SDK40", "${env:ProgramFiles(x86)}\Microsoft SDKs\Windows\v7.0A\bin\NETFX 4.0 Tools\")
}

if (Test-Path "${env:ProgramFiles}\Microsoft SDKs\Windows\v8.1A\bin\NETFX 4.5.1 Tools\") {
  [Environment]::SetEnvironmentVariable("SDK451", "${env:ProgramFiles}\Microsoft SDKs\Windows\v8.1A\bin\NETFX 4.5.1 Tools\")
} elseif (Test-Path "${env:ProgramFiles(x86)}\Microsoft SDKs\Windows\v8.1A\bin\NETFX 4.5.1 Tools\") {
  [Environment]::SetEnvironmentVariable("SDK451", "${env:ProgramFiles(x86)}\Microsoft SDKs\Windows\v8.1A\bin\NETFX 4.5.1 Tools\")
}

if (Test-Path "${env:ProgramFiles}\Microsoft SDKs\Windows\v10.0A\bin\NETFX 4.6 Tools\") {
  [Environment]::SetEnvironmentVariable("SDK46", "${env:ProgramFiles}\Microsoft SDKs\Windows\v10.0A\bin\NETFX 4.6 Tools\")
} elseif (Test-Path "${env:ProgramFiles(x86)}\Microsoft SDKs\Windows\v10.0A\bin\NETFX 4.6 Tools\") {
  [Environment]::SetEnvironmentVariable("SDK46", "${env:ProgramFiles(x86)}\Microsoft SDKs\Windows\v10.0A\bin\NETFX 4.6 Tools\")
}

if (Test-Path "${env:ProgramFiles}\Microsoft SDKs\Windows\v10.0A\bin\NETFX 4.6.1 Tools\") {
  [Environment]::SetEnvironmentVariable("SDK461", "${env:ProgramFiles}\Microsoft SDKs\Windows\v10.0A\bin\NETFX 4.6.1 Tools\")
} elseif (Test-Path "${env:ProgramFiles(x86)}\Microsoft SDKs\Windows\v10.0A\bin\NETFX 4.6.1 Tools\") {
  [Environment]::SetEnvironmentVariable("SDK461", "${env:ProgramFiles(x86)}\Microsoft SDKs\Windows\v10.0A\bin\NETFX 4.6.1 Tools\")
}

# user repositories
[Environment]::SetEnvironmentVariable("UserRepositories", "${env:UserProfile}");