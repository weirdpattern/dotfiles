Param(
    [Parameter(Mandatory=$True, Position=0)]
	[String]$Command,
	
    [Parameter(Mandatory=$False, Position=1, ValueFromRemainingArguments=$True)]
	$Arguments
)

##
# Ensures the current user has admin access or requests it.
##
function Assert-AdminAccess {
    if( -Not ([System.Security.Principal.WindowsIdentity]::GetCurrent().UserClaims | ? { $_.Value -eq 'S-1-5-32-544'}) ) {
	    Write-Host("You need to be part of the Administrator group to execute sudo commands") -ForegroundColor Red
	    Exit 1
    }
}

##
# Formats and escapes the arguments.
##
function Format-Arguments {
    Param(
	    [Parameter(Mandatory=$True)]$Raw, 
		[Parameter(Mandatory=$False)]$Escape = $False
    )
	
	if( $Raw -is [String] -and $Raw -match '\s' ) { return "'$Raw'" }
	if( $Raw -is [Array] ) { return $Raw | % { (Format-Arguments $_ $Escape) -join ', ' }}
	if( $Escape ) { return $Raw -replace '[>&]', '`$0' }
	
	return $Raw
}

Assert-AdminAccess

$private:title = $Host.UI.RawUI.WindowTitle

$private:workingDirectory = Format-Arguments (Convert-Path $pwd)
$private:script = (Join-Path (Split-Path -parent $MyInvocation.MyCommand.Path) 'detach-command.ps1')

if( $Arguments ) {
	$private:executionCommand = Format-Arguments @($Command, $Arguments) $True
} else {
	$private:executionCommand = Format-Arguments $Command $True
}

$private:process = New-Object Diagnostics.Process; 
$private:start = $private:process.StartInfo
$private:start.Filename = "PowerShell.exe"
$private:start.Arguments = "-NoProfile & '$private:script' '$private:executionCommand' '$private:workingDirectory' `nexit `$LastExitCode"
$private:start.Verb = 'RunAs'
$private:start.WindowStyle = 'hidden'

$private:process.Start() 2>&1>$Null  
$private:process.WaitForExit()

$Host.UI.RawUI.WindowTitle = $private:title

exit $private:process.ExitCode