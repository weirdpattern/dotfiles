Import-Module posh-git

##
# Overrides the PS prompt.
##
function Prompt {
  $path = $pwd.Path -ireplace $([regex]::Escape($env:UserProfile)), '~'
  
  $host.UI.RawUi.WindowTitle = $pwd.Path
  
  Write-Host -backgroundColor $Host.UI.RawUI.BackgroundColor
  Write-Host($path) -NoNewLine -ForegroundColor DarkYellowk
  Write-VcsStatus
  Write-Host(' ') 
  Write-Host('$') -NoNewLine -ForegroundColor DarkYellow
  return " "
}
