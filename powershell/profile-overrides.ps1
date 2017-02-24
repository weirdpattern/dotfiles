####################################################################
# Overrides settings in profile.ps1 like aliases, functions, etc #
####################################################################

# Notepad++ as default editor
[Environment]::SetEnvironmentVariable("EDITOR", "$env:ProgramFiles\Notepad++\notepad++.exe", "User")
[Environment]::SetEnvironmentVariable("SDK40", "${env:ProgramFiles(x86)}\Microsoft SDKs\Windows\v7.0A\bin\NETFX 4.0 Tools\")
[Environment]::SetEnvironmentVariable("SDK451", "${env:ProgramFiles(x86)}\Microsoft SDKs\Windows\v8.1A\bin\NETFX 4.5.1 Tools\")
[Environment]::SetEnvironmentVariable("SDK46", "${env:ProgramFiles(x86)}\Microsoft SDKs\Windows\v10.0A\bin\NETFX 4.6 Tools\")
[Environment]::SetEnvironmentVariable("SDK461", "${env:ProgramFiles(x86)}\Microsoft SDKs\Windows\v10.0A\bin\NETFX 4.6.1 Tools\")