#!/bin/bash

##
# Requests confirmation from the user.
##
function confirm {
  result=-1
  while [[ $result = -1 ]]; do
    # Confirms with the user expecting only one letter
    read -p "$1 (y/n) " -n 1 -r response
    
    # Y|y returns 0, N|n returns 1
    if [[ $response =~ ^[Nn]$ ]]; then
      result=1
    elif [[ $response =~ ^[Yy]$ ]]; then      
      result=0
    fi
  done 
  
  echo $result
}

##
# Displays a success message.
##
function success {
  echo "$(tput setaf 2)[✔]$1$(tput sgr 0)"
}

##
# Displays a warning message.
##
function warning {
  echo "$(tput setaf 3)[!]$1$(tput sgr 0)"
}

##
# Displays an error message.
##
function error {
  echo "$(tput setaf 1)[✘]$1$(tput sgr 0)"
  exit 1
}

##
# Loops through the passed array.
##
function foreach {  
  # Get the command to execute
  cmd=$1; shift
  
  # Loop the items in the array
  for item in $@; do
    echo "Executing $cmd $item"
    if [[ $(eval $cmd $item) ]]; then
      success "$item installed successfully"
    else
      warning "$item could not be installed"
    fi
  done
}