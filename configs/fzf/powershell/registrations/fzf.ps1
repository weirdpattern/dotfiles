if ($host.Name -eq 'ConsoleHost')
{
    if (-not (Get-Module -ListAvailable -Name "PSReadLine"))
    {
        Install-Module PSReadLine -AcceptLicense -Confirm
    }

    Import-Module PSReadLine    
}

if (-not (Get-Module -ListAvailable -Name "PSfzf"))
{
    Install-Module PSfzf -AcceptLicense -Confirm
}

Import-Module PSfzf

Set-PsFzfOption -TabExpansion

Set-PSReadLineKeyHandler -Key Tab -ScriptBlock { Invoke-FzfTabCompletion }

Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+e' `
                -PSReadlineChordReverseHistory 'Ctrl+r'