Set-Alias ls Private:EzaListingLS
function Private:EzaListingLS {
  & (Get-Command eza).Source --color=always --icons=always --long --header --group-directories-first ${Args}
}

Set-Alias ll Private:EzaListingLL
function Private:EzaListingLL {
  & (Get-Command eza).Source --color=always --icons=always --all --long --header --group-directories-first ${Args}
}

Set-Alias tree Private:EzaTree
function Private:EzaTree {
  & (Get-Command eza).Source --color=always --icons=always --header --tree ${Args}
}

Set-Alias files Private:EzaFiles
function Private:EzaFiles {
  & (Get-Command eza).Source --color=always --icons=always --no-quotes --only-files --header --oneline ${Args}
}

Set-Alias directories Private:EzaDirectories
function Private:EzaDirectories {
  & (Get-Command eza).Source --color=always --icons=always --no-quotes --only-dirs --header --oneline ${Args}
}
