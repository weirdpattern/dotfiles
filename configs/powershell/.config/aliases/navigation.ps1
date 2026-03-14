function .. {
  param(
    [int]$Levels = 1
  )

  $Private:Path = ""

  while ($Levels -gt 0) {
    $Private:Path += "../"
    $Levels -= 1
  }

  Set-Location $Private:Path
}

function ~ {
  Set-Location $env:UserProfile
}

function ... {
  Set-Location $env:UserProfile
}

function Finder {
  Invoke-Item $pwd
}