###########
# General #
###########
#
  # Enable vim
  Set-Alias vi "C:\Program Files (x86)\Vim\vim80\vim.exe"
  Set-Alias vim "C:\Program Files (x86)\Vim\vim80\vim.exe"
  
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
  function hosts { Start-Process "$env:EDITOR" "$env:windir\System32\Drivers\Etc\Hosts" -Verb runAs }
  
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
  
  # Go back home
  function ~ { 
    Set-Location $env:UserProfile
    Get-ChildItem .
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