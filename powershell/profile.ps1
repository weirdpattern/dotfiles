# Set the background
$console = $host.UI.RawUI
$console.BackgroundColor = 'Black'

# Set the location to be used to execute the scripts
Push-Location (Split-Path -Path $MyInvocation.MyCommand.Definition -Parent)

# Include the scripts
. .\.ps\profile-exports.ps1
. .\.ps\profile-aliases.ps1
. .\.ps\profile-overrides.ps1
. .\.ps\profile-prompt.ps1

# Set the current location
Set-Location $env:UserProfile

# Clear host to apply changes
Clear-Host