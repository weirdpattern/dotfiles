$console = $host.UI.RawUI
$console.BackgroundColor = 'Black'

Push-Location (Split-Path -Path $MyInvocation.MyCommand.Definition -Parent)

$registrations = Get-ChildItem ./registrations/*.ps1
foreach ($registration in $registrations) {
  . "$registration"
}

$aliases = Get-ChildItem ./aliases/*.ps1
foreach ($alias in $aliases) {
  . "$alias"
}

$exports = Get-ChildItem ./exports/*.ps1
foreach ($export in $exports) {
  . "$export"
}

Pop-Location

Push-Location $HOME

Clear-Host
Clear-Host
