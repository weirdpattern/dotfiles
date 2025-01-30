Set-Alias preview bat

Set-Alias cat Private:Invoke-Cat
function Private:Invoke-Cat {
  & (Get-Command bat).Source --paging=never $Args
}

Set-Alias help Private:Help
function Private:Help {
  Param([String]$Command)
  Get-Help $Command @Args | bat --language=man --theme=TwoDark --style=plain
}
