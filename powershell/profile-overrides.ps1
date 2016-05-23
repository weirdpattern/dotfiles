####################################################################
# Overrides settings in profile.ps1 like aliases, functions, etc #
####################################################################

# Notepad++ as default editor
[Environment]::SetEnvironmentVariable("EDITOR", "$env:programfiles\Notepad++\notepad++.exe", "User")