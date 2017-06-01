Import-Module posh-git

###########
# General #
###########
#
  # Enable vim
  Set-Alias vi "${env:EDITOR}"
  Set-Alias vim "${env:EDITOR}"

  # Enable sudo shortcut
  Set-Alias sudo ( %{'{0}\{1}' -f $PSScriptRoot, "sudo.ps1"} )
#
###

##############
# Networking #
##############
#
  # Gets the computer ip address
  Set-Alias ip ipconfig

  # Flush DNS cache
  function flush-dns { sudo ipconfig /FlushDns }

  # Opens hosts file
  function hosts { Start-Process "$env:EDITOR" "${env:windir}\System32\Drivers\Etc\Hosts" -Verb runAs }

  # Operates IIS
  function iis {
      Param(
      [Parameter(Mandatory=$True)]
      [string]$Operation
    )

    if ($Operation -imatch "restart") {
      Write-Host Restarting IIS...
      sudo iisreset /Restart
      Write-Host IIS Restarted
    } elseif ($Operation -imatch "start") {
      Write-Host Starting IIS...
      sudo iisreset /Start
      Write-Host IIS Started
    } elseif ($Operation -imatch "stop") {
      Write-Host Stopping IIS...
      sudo iisreset /Stop
      Write-Host IIS Stopped
    }
  }
#
###

#############################
# Command Prompt navigation #
#############################
#
  # Go back one level and list content
  function .. {
    Param([Int]$Number = 1)
    $private:path = ""
    while ($Number -gt 0) {
      $private:path += "../"
      $Number -= 1
    }

    Set-Location $private:path
    Get-ChildItem .
  }

  function back {
    Param([Int]$Number = 1)
    $private:path = ""
    while ($Number -gt 0) {
      $private:path += "../"
      $Number -= 1
    }

    Set-Location $private:path
    Get-ChildItem .
  }

  # Go back home
  function ~ {
    Set-Location $env:UserProfile
    Get-ChildItem .
  }

  # Open up the repositories
  function repo {
    Set-Location $env:UserRepositories
    Get-ChildItem .
  }
  
  # Enable explorer integration
  function finder {
    Invoke-Item $pwd 
  } 

  # Clear shorcuts
  Set-Alias clr Clear-Host
  Set-Alias clrsrc Clear-Host

  # Create directories
  Set-Alias mk mkdir
  Set-Alias mkcd mkdircd  

  # Creates a new folder and navigates to it
  function mkdircd {
    Param([String]$Name)
    New-Item $Name -ItemType Directory
    Set-Location $Name
  }
#
###

################
# Git #
################
#
  # Loops through all the repositories pulling in new data
  function repo-update {
    Param([Switch]$all)

    if ($all) {
      $items = Get-ChildItem -Path $env:UserRepositories -Attributes Directory,Directory+Hidden -Include '.git' -Recurse
      $maxLength = ($items `
        | Select-Object -Property @{Name="Length";Expression={((Split-Path(Split-Path $_ -Parent) -Leaf)).Length}} `
        | Measure-Object -Maximum -Property Length).Maximum

      $items | ForEach-Object {
        $parent = (Split-Path $_ -Parent)
		    $repo = (Split-Path $parent -Leaf)

		    Push-Location -Path $parent

		    Write-Host $repo.PadRight($maxLength, ' ') -NoNewLine
		    Write-Host ' ' -NoNewLine
        git pull

        Pop-Location
      }
    } else {
      Write-Host Updating $pwd

      git pull

      Write-Host
    }
  }

  # Loops through all the repositories getting the status
  function repo-status {
    Param([Switch]$all)

    if ($all) {
	    $items = Get-ChildItem -Path $env:UserRepositories -Attributes Directory,Directory+Hidden -Include '.git' -Recurse
	    $maxLength = ($items `
        | Select-Object -Property @{Name="Length";Expression={((Split-Path(Split-Path $_ -Parent) -Leaf)).Length}} `
        | Measure-Object -Maximum -Property Length).Maximum

	    $items | ForEach-Object {
	      $parent = (Split-Path $_ -Parent)
        $repo = (Split-Path $parent -Leaf)

        Push-Location -Path $parent

        Write-Host $repo.PadRight($maxLength, ' ') -NoNewLine
		    Write-Host (Write-VcsStatus)

		    Pop-Location
	    }
    } else {
      Write-Host (Split-Path(Split-Path $pwd) -Leaf) $(Write-VcsStatus)
    }
  }
#
###

############
# Sessions #
############
#
  # Adds Visual Studio folder to PATH
  function add-sdk {
    Param([String]$Version = "4.6.1")
    switch ($Version) {
      "4.0" {
        $env:Path += ";$env:SDK40"
      }
      "4.5.1" {
        $env:Path += ";$env:SDK451"
      }
      "4.6" {
        $env:Path += ";$env:SDK46"
      }
      default {
        $env:Path += ";$env:SDK461"
      }
    }
  }
#
###

