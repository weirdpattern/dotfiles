##
# Install Chocolatey
##
function Install-Chocolatey {
  (New-Object Net.WebClient).DownloadString("https://chocolatey.org/install.ps1") | iex
}

##
# Install PsGet
##
function Install-PsGet {
  Param(
    [Parameter(Mandatory=$True)]
    [string]$ModulesPath
  )

  $oldPSModulePath = $env:PSModulePath
  $env:PSModulePath = $ModulesPath
  (New-Object Net.WebClient).DownloadString("http://psget.net/GetPsGet.ps1") | iex
  $env:PSModulePath = $oldPSModulePath
}

##
# Gets profile information based on the type of profile.
##
function Get-ProfileInfo {
  Param(
    [Parameter(Mandatory=$True)]
    [string]$ProfileType
  )

  switch ($ProfileType) {
    "CurrentUserAllHosts"    { return @( $Profile.CurrentUserAllHosts, "" ) }
    "CurrentUserCurrentHost" { return @( $Profile.CurrentUserCurrentHost, "Microsoft.PowerShell_" ) }
    "AllUsersAllHosts"       { return @( $Profile.AllUsersAllHosts, "" ) }
    "AllUsersCurrentHost"    { return @( $Profile.AllUsersCurrentHost, "Microsoft.PowerShell_" ) }
  }

  throw "No profile has been specified!"
}

##
# Setups the requested profile.
##
function Setup-Profile {
  Param(
    [Parameter(Mandatory=$True)]
    [string]$CurrentPath,

    [Parameter(Mandatory=$True)]
    [string]$ProfileType
  )

  $profilePath, $filePrefix = Get-ProfileInfo $ProfileType
  $modulesPath = Join-Path -Path (Split-Path $profilePath -Parent) -ChildPath "Modules"

  Set-ExecutionPolicy RemoteSigned
  Install-Chocolatey
  Install-PsGet $modulesPath | Out-Null
  Install-Module posh-git -Destination $modulesPath | Out-Null

  $process = $True
  if (Test-Path $profilePath) {
    $title = "Profile already exists!"
    $message = "Would you like to replace it?"

    $yes= New-Object System.Management.Automation.Host.ChoiceDescription "&Replace Profile", `
      "Replaces the current user profile."

    $no = New-Object System.Management.Automation.Host.ChoiceDescription "&Keep Profile", `
      "Keeps the current user profile."

    $options = [System.Management.Automation.Host.ChoiceDescription[]]($yes, $no)
    $result = $host.ui.PromptForChoice($title, $message, $options, 0)
    if ($result -eq 1) {
      $process = $False
    }
  }

  if ($process) {
    $profileLocation = Split-Path $profilePath -Parent
    $psScriptLocation = Join-Path -Path $profileLocation -ChildPath ".ps"
    if (-Not (Test-Path $psScriptLocation)) {
      New-Item $psScriptLocation -Type Directory | %{$_.Attributes = "hidden"}
    }

    Get-ChildItem $CurrentPath -Exclude @("profile.ps1", "setup.cmd", "setup.ps1") | Copy-Item -Destination $psScriptLocation -Force
    Copy-Item (Join-Path $CurrentPath "profile.ps1") -Destination (Join-Path $profileLocation ($filePrefix + "profile.ps1")) -Force

    Write-Host ""
    Write-Host "Profile updated!"
  }
}

##
# Ensures the current user has admin access or requests it.
##
function Assert-AdminAccess {
  $user = [Security.Principal.WindowsIdentity]::GetCurrent();
  $principal = New-Object Security.Principal.WindowsPrincipal $user

  $hasAdminClaim = $user.UserClaims | ? { $_.Value -eq 'S-1-5-32-544'}
  $isAdmin = $principal.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)

  if ((-Not $isAdmin) -Or (-Not $hasAdminClaim)) {
    Write-Host ""
    Write-Host "To setup All Users profile you need to run the command in admin mode" -ForegroundColor Red
    Exit 1
  }
}

$currentLocation = Split-Path $MyInvocation.MyCommand.Definition -Parent

$title = "PowerShell Profile Setup"
$message = "Setup profile for:"

$currentUserAllHosts= New-Object System.Management.Automation.Host.ChoiceDescription "&Current User All Hosts", `
  "Setup Current User's PowerShell Profile for all Hosts."

$currentUserCurrentHost= New-Object System.Management.Automation.Host.ChoiceDescription "Current &User Current Host", `
  "Setup Current User's PowerShell Profile for the Current Host."

$allUsersAllHosts = New-Object System.Management.Automation.Host.ChoiceDescription "&All Users All Hosts", `
  "Setup All User's PowerShell Profile for all Hosts."

$allUsersCurrentHost = New-Object System.Management.Automation.Host.ChoiceDescription "All Users All &Hosts", `
  "Setup All User's PowerShell Profile for all Hosts."

$cancel = New-Object System.Management.Automation.Host.ChoiceDescription "Ca&ncel", `
  "Cancel the setup."

$options = [System.Management.Automation.Host.ChoiceDescription[]]($currentUserAllHosts, $currentUserCurrentHost, $allUsersAllHosts, $allUsersCurrentHost, $cancel)
$result = $host.ui.PromptForChoice($title, $message, $options, 1)
switch ($result) {
  0 {
    Write-Host "Setting up Current User All Hosts"
    Setup-Profile $currentLocation "CurrentUserAllHosts"
  }

  1 {
    Write-Host "Setting up Current User Current Host"
    Setup-Profile $currentLocation "CurrentUserCurrentHost"
  }

  2 {
    Assert-AdminAccess

    Write-Host "Setting up All User All Hosts"
    Setup-Profile $currentLocation "AllUsersAllHosts"
  }

  3 {
    Assert-AdminAccess

    Write-Host "Setting up All User Current Host"
    Setup-Profile $currentLocation "AllUsersCurrentHost"
  }
}
