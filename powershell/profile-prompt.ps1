##
# Test git availability and presence on current folder.
##
function Test-GitRepository {
    return (Get-Command "git" 2>$Null) `
      -and ((git rev-parse --is-inside-work-tree) 2>$Null) `
      -and (-not (git rev-parse --is-inside-git-dir) 2>$Null)
}

##
# Extracts status details about the repo.
##
function Get-GitStatus {
    $private:branch = (git symbolic-ref --quiet --short HEAD) 2>$Null
    if (-not $?) { $private:branch = (git rev-parse --short HEAD) 2>$Null }
    if (-not $?) { $private:branch = "(unknown)" }

    $private:output = git diff --name-status --ignore-submodules
    $private:added = ($private:output | ? { $_ -imatch "^A" }).Count 
    $private:deleted = ($private:output | ? { $_ -imatch "^D" }).Count
    $private:modified = ($private:output | ? { $_ -imatch "^[M|R]" }).Count 
    $private:untracked = (git ls-files --others --exclude-standard).Count
    $private:stashed = ((git rev-parse --verify refs/stash) 2>$Null).Count   
    
    return @{"branch" = $branch;
             "added" = $private:added;
             "deleted" = $private:deleted;
             "modified" = $private:modified;
             "untracked" = $private:untracked;
             "stashed" = $private:stashed;
             "changed" = $private:untracked + $private:added + $private:modified + $private:deleted}
}

##
# Overrides the PS prompt.
##
function Prompt {
    $path = $pwd.Path -ireplace $([regex]::Escape($env:UserProfile)), '~'
    
    $host.UI.RawUi.WindowTitle = $pwd.Path
    
    Write-Host -backgroundColor $Host.UI.RawUI.BackgroundColor
    
    Write-Host([Environment]::Username) -NoNewLine -ForegroundColor Red
    Write-Host(" @ ") -NoNewLine -ForegroundColor DarkGray
    Write-Host($path) -NoNewLine -ForegroundColor DarkGreen
    
    if (Test-GitRepository) {
        $git = Get-GitStatus
        Write-Host(" on ") -NoNewLine -ForegroundColor DarkGray
        Write-Host($git["branch"]) -NoNewLine -ForegroundColor Cyan
        if ($git["changed"] -gt 0) {
            Write-Host(" [ ") -NoNewLine -ForegroundColor DarkGray
            Write-Host($git["added"]) -NoNewLine -ForegroundColor Cyan
            Write-Host("+ ") -NoNewLine -ForegroundColor Cyan
            Write-Host($git["deleted"]) -NoNewLine -ForegroundColor Cyan
            Write-Host("- ") -NoNewLine -ForegroundColor Cyan
            Write-Host($git["modified"]) -NoNewLine -ForegroundColor Cyan
            Write-Host("! ") -NoNewLine -ForegroundColor Cyan
            Write-Host($git["untracked"]) -NoNewLine -ForegroundColor Cyan
            Write-Host("? ") -NoNewLine -ForegroundColor Cyan
            Write-Host($git["stashed"]) -NoNewLine -ForegroundColor Cyan
            Write-Host("$ ") -NoNewLine -ForegroundColor Cyan
            Write-Host("]") -NoNewLine -ForegroundColor DarkGray
        }
    }    
    
    Write-Host(' ') 
    Write-Host('$') -NoNewLine -ForegroundColor Red    
    return " "
}