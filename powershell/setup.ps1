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
    (new-object Net.WebClient).DownloadString("http://psget.net/GetPsGet.ps1") | iex
    $env:PSModulePath = $oldPSModulePath
}

##
# Setups the requested profile.
##
function Setup-Profile {
    Param(
        [Parameter(Mandatory=$True)]
        [string]$CurrentPath,
        
        [Parameter(Mandatory=$True)]
        [string]$ProfilePath
    )

    $modulesPath = Join-Path -Path (Split-Path $ProfilePath -Parent) -ChildPath "Modules"

    Set-ExecutionPolicy RemoteSigned
    Install-PsGet $modulesPath | Out-Null
    Install-Module posh-git -Destination $modulesPath | Out-Null

    Remove-Item $Profile -Force

    $process = $True
    if (Test-Path $ProfilePath) {
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
        $profileLocation = Split-Path $ProfilePath -Parent
        $psScriptLocation = Join-Path -Path $profileLocation -ChildPath ".ps"
        if (-Not (Test-Path $psScriptLocation)) {
            New-Item $psScriptLocation -Type Directory | %{$_.Attributes = "hidden"}
        }
        
        Get-ChildItem $CurrentPath -Exclude @("profile.ps1", "setup.cmd", "setup.ps1") | Copy-Item -Destination $psScriptLocation -Force
        Copy-Item (Join-Path $CurrentPath "profile.ps1") -Destination $profileLocation -Force
        
        Write-Host ""
        Write-Host "Profile updated!"
        Write-Host "Press enter to continue"
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

$currentUser= New-Object System.Management.Automation.Host.ChoiceDescription "&Current User", `
    "Setup Current User's PowerShell Profile."

$allUsers = New-Object System.Management.Automation.Host.ChoiceDescription "&All Users", `
    "Setup All User's PowerShell Profile."
    
$cancel = New-Object System.Management.Automation.Host.ChoiceDescription "Ca&ncel", `
    "Cancel the setup."

$options = [System.Management.Automation.Host.ChoiceDescription[]]($currentUser, $allUsers, $cancel)
$result = $host.ui.PromptForChoice($title, $message, $options, 0)
switch ($result) {
    0 { 
        Write-Host "Setting up Current User" 
        Setup-Profile $currentLocation $Profile.CurrentUserAllHosts
    }
    1 { 
        Assert-AdminAccess
        
        Write-Host "Setting up All User"
        Setup-Profile $currentLocation $Profile.AllUsersAllHosts
    }
}