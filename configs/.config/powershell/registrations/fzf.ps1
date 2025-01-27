if ($host.Name -eq 'ConsoleHost')
{
    Import-Module PSReadLine
}

Import-Module PSfzf

Set-PsFzfOption -TabExpansion

Set-PSReadLineKeyHandler -Key Tab -ScriptBlock { Invoke-FzfTabCompletion }

Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+e' `
                -PSReadlineChordReverseHistory 'Ctrl+r'
