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

  function mkcd {
    Param([String]$Name)
    New-Item $Name -ItemType Directory
    Set-Location $Name
  }

  function mkdircd {
    Param([String]$Name)
    New-Item $Name -ItemType Directory
    Set-Location $Name
  }
#
###

#############################
# Command Prompt operations #
#############################
#
  # Clear shorcuts
  Set-Alias clr Clear-Host
  Set-Alias clrsrc Clear-Host  

  # Create directories
  Set-Alias mk mkdir
  Set-Alias mkcd mkdircd  
#
###

################
# Applications #
################
#
  # Set git alias
  Set-Alias g git
  
  # Gets the status of a git repository
  function status { git status }
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

