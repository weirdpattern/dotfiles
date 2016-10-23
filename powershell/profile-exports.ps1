####################################################################
# Overrides settings in profile.ps1 like aliases, functions, etc #
####################################################################

# Notepad++ as default editor
if (Test-Path "$env:programfiles\Notepad++\notepad++.exe") {
    [Environment]::SetEnvironmentVariable("EDITOR", "$env:programfiles\Notepad++\notepad++.exe", "User")
} elseif (Test-Path "${env:programfiles(x86)}\Notepad++\notepad++.exe") {
	[Environment]::SetEnvironmentVariable("EDITOR", "${env:programfiles(x86)}\Notepad++\notepad++.exe", "User")
} else {
    [Environment]::SetEnvironmentVariable("EDITOR", "$env:windir\System32\notepad.exe", "User")
}