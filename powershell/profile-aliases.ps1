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
  function Flush-DNS { sudo ipconfig /FlushDns }

  # Opens hosts file
  function Hosts { Start-Process "$env:EDITOR" "${env:windir}\System32\Drivers\Etc\Hosts" -Verb runAs }

  # Operates IIS
  function IIS {
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

  function Back {
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

  # Enable explorer integration
  function Finder {
    Invoke-Item $pwd
  }

  # Clear shorcuts
  Set-Alias clr Clear-Host
  Set-Alias clrsrc Clear-Host

  # Create directories
  Set-Alias mk mkdir
  Set-Alias mkcd mkdircd

  # Creates a new folder and navigates to it
  function MKDirCD {
    Param([String]$Name)
    New-Item $Name -ItemType Directory
    Set-Location $Name
  }
#
###

#######
# Git #
#######
#
  # Open up the repositories
  function Sandbox {
    Set-Location $env:Sandbox
    Get-ChildItem .
  }
  
  # Open up the deployment folder
  function Deployment {
	Set-Location $env:Deployment
	Get-ChildItem .
  }

  # Loops through all the repositories pulling in new data
  function Update-Sandbox {
    Param([Switch]$All)

    if ($All) {
      $items = Get-ChildItem -Path $env:Sandbox -Attributes Directory,Directory+Hidden -Include '.git' -Recurse
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
  function Show-Status-Sandbox {
    Param([Switch]$All)

    if ($All) {
	    $items = Get-ChildItem -Path $env:Sandbox -Attributes Directory,Directory+Hidden -Include '.git' -Recurse
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

  function Clone-Repository {
    Param(
      [string]$Repository,
      [switch]$OpenCode
    )

    git clone $Repository

    Set-Location (Get-childItem . `
      | Where-Object { $_.PSIsContainer } `
      | Sort-Object CreationTime -Descending `
      | Select-Object -First 1)

    git config user.name $Env:GitUserName
    git config user.email $Env:GitUserEmail

    if ($OpenCode) {
      code .
    }
  }
#
###

##############
# SQL Server #
##############
#
  function Start-SQLDatabase {
	Param(
	  [string]$ComputerName = $env:ComputerName,
	  [string]$Instance = "MSSQLSERVER"
	)	
	
	Import-Module "sqlps" -DisableNameChecking
	
	cd "SQLSERVER:\SQL\$ComputerName"
	$Wmi = (get-item .).ManagedComputer
	$DatabaseInstance = $Wmi.Services[$Instance]
	$DatabaseInstance.Start()
	$DatabaseInstance.Refresh()
	
	Write-Host "Database started"
  }
  
  function Stop-SQLDatabase {
	Param(
	  [string]$ComputerName = $env:ComputerName,
	  [string]$Instance = "MSSQLSERVER"
	)
	
	Import-Module "sqlps" -DisableNameChecking
	
	cd "SQLSERVER:\SQL\$ComputerName"
	$Wmi = (get-item .).ManagedComputer
	$DatabaseInstance = $Wmi.Services[$Instance]
	$DatabaseInstance.Stop()
	$DatabaseInstance.Refresh()
	
	Write-Host "Database stopped"
  }
#
###