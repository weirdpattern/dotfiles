Set-Alias Find Find-InFiles

function Find-InFiles {
  Param (
    [String]$Terms,
    [Switch]$Recurse
  )
  if ($Recurse.IsPresent) {
    strings -s * | findstr /i $Terms
  } else {
    strings * | findstr /i $Terms
  }
}
