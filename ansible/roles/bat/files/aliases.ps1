Set-Alias preview bat

Set-Alias cat Private:Invoke-Cat
function Private:Invoke-Cat {
  & (Get-Command bat).Source --paging=never ${Args}
}

Set-Alias help Private:Help
function Private:Help {
  param([string]$Command)

  Get-Help $Command | bat --language=man --theme=TwoDark
}
