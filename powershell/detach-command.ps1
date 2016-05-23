Param(
    [Parameter(Mandatory=$True, Position=0)][String]$Command,
    [Parameter(Mandatory=$True, Position=1)][String]$Directory
)
    
$private:process = New-Object Diagnostics.Process; 
$private:start = $private:process.StartInfo
$private:start.Filename = "PowerShell.exe"
$private:start.Arguments = "-NoProfile $Command `nexit `$LastExitCode"
$private:start.UseShellExecute = $False
$private:start.WorkingDirectory = $Directory

$private:process.Start()
$private:process.WaitForExit()

exit $private:process.ExitCode