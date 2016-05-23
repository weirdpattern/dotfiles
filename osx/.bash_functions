#!/bin/env bash

################
# Applications #
################
#
  ##
  # Opens Visual Studio Code in the current location (folder).
  ##
  function code {
    VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $*;
  }
  
  ##
  # Opens a repository in Visual Studio Code.
  ##
  function code-repo {
    VSCODE_CWD="$REPO_HOME/$1" open -n -b "com.microsoft.VSCode" --args $REPO_HOME/$1;
  }
  
  ##
  # Performs updates on application managers such as npm and brew.
  #   all, updates everything.
  #   brew, updates brew applications.
  #   node | npm, updates npm packages.
  ##
  function update {
    sudo -v
    while true; do sudo -n /dev/true; sleep 60; echo "$$"; kill -0 "$$" || exit; done 2>/dev/null &
    
    OPTION="$1" 
    
    case $OPTION in
    
      # Updates everything
      [Aa][Ll][Ll] )
        update-brew
        update-npm
        ;;
      
      # Updates brew packages
      [Bb][Rr][Ee][Ww] )       
        update-brew        
        ;;
        
      # Updates node/npm packages
      [Nn][Oo][Dd][Ee] | [Nn][Pp][Mm] )        
        update-npm
        ;;
      
      # Default cases  
      *)
        echo "$OPTION command not recognized"        
        ;;
        
    esac
  }
  
  ##
  # Updates brew applications.
  ##
  function update-brew {
    echo "Updating brew"
    echo ""
    
    brew -v update
    brew -v upgrade --all        
        
    brew prune
    brew doctor
        
    brew cleanup
    brew cask cleanup
  }
  
  ##
  # Updates npm packages.
  ##
  function update-npm {
    echo "Updating npm"
    echo ""
    
    local pkg=$(find . -iname "package.json" -type f -maxdepth 1)
        
    echo "Estimating required updates"
    echo ""
                
    if [[ ! -e "$pkg" ]]; then
      local count=$(npm outdated -g -parseable | wc -l)
      if [[ $count == 0 ]]; then
        echo "All packages up to date"
      else
        echo "Searching for out of date packages"
        npm outdated -g
            
        echo ""
        read -r -p "Would you like to update these packages (y/n) " response
        echo ""        
        if [[ $response =~ ^([Yy]|[Yy][Ee][Ss])$ ]]; then
          npm update -g
        fi                         
      fi
      else
        local count=$(npm outdated -parseable | wc -l)
        if [[ $count == 0 ]]; then
          echo "All packages up to date"
        else
          echo "Searching for out of date packages"
          npm outdated
            
          echo ""
          read -r -p "Would you like to update these packages (y/n) " response
          echo ""
          if [[ $response =~ ^([Yy]|[Yy][Ee][Ss])$ ]]; then
            npm update
          fi                         
        fi
      fi  
  }
#
###

############
# Terminal #
############
#
  ##
  # Go back n levels and list content
  ##
  function back {
    local path="../"    
    local number=$1 

    if [[ $number =~ ^[0-9]+$ ]]; then            
      while [ $number -gt 1 ]; do              
        path+="../"
        number=$((number-1))
      done
    fi
    
    cd $path
    ls  
  }
  
  ##
  # Creates a backup of a file
  ##
  function backup {
    if [[ -d $1 ]]; then  
      zip -r $1-$(date +'%m%d%y%H%M').zip $1
    else
      cp -i $1 ${1%.*}-$(date +'%m%d%y%H%M').${1#*.}.bkp                  
    fi
  }

  ##
  # Makes a directory and navigates to it.
  ##
  function mkcd {
    mkdir -p $1 && cd $1
  }
  
  ##
  # Makes a directory and navigates to it.
  ##
  function mkdircd {
    mkdir -p $1 && cd $1
  }
  
  ##
  # Searches a term in the current directory.
  ##
  function search {
    command find . -name $1  
  }
  
  ##
  # Searches files in the current directory.
  ##
  function search-files {
    command find . -type f -name $1
  }
  
  ##
  # Searches directories in the current directory.
  ##
  function search-directories {
    command find . -type d -name $1
  }
  
  ##
  # Moves the specified file/directory to trash.
  ##
  function trash {
    command mv $1 ~/.Trash
  }
  
  ##
  # Empties the trash.
  #   -a | --all, empties all trashes.  
  #   -l | --log, empties asl logs.
  #   -m | --mounted, empties mounted trashes.
  ##
  function empty-trash {
    while [[ $# > 0 ]]; do
      case $1 in
        # empty all
        -[Aa] | --[Aa][Ll][Ll] ) 
          sudo rm -rf /private/var/log/asl/*.asl
          sudo rm -rf /Volumes/*/.Trashes/*
          ;;
          
        # empty logs  
        -[Ll] | --[Ll][Oo][Gg] )
          sudo rm -rf /private/var/log/asl/*.asl
          ;;
        
        # empty mounted units
        -[Mm] | --[Mm][Oo][Uu][Nn][Tt][Ee][Dd] )
          sudo rm -rf /Volumes/*/.Trashes/*
          ;;
  
        # unknown options     
        * )
          break           
          ;;
          
      esac
      
      # skip argument
      shift
    done

    # always empty Trash in $HOME
    sudo rm -rf ${HOME}/.Trash/*
  }
#
###

#######
# Git #
#######
#
##
  ##
  # Opens the repository folder.
  ##
  function repo {
    
    if [[ "$1" ]]; then 
      cd "$REPO_HOME/$1"
    else
      cd "$REPO_HOME"
    fi
        
    ls
  }
  
  ##
  # Opens a browser to the current git repository
  ##
  function browse {
    local giturl=$(git config --get remote.origin.url | sed 's/git@/\/\//g' | sed 's/.git$//' | sed 's/https://g' | sed 's/:/\//g')
    if [[ $giturl == "" ]]; then
      echo "Not a git repository or no remote.origin.url is set."
    else
      local gitbranch=$(git rev-parse --abbrev-ref HEAD)
      local giturl="http:${giturl}"

      if [[ $gitbranch != "master" ]]; then
        local giturl="${giturl}/tree/${gitbranch}"
      fi

      echo "Opening $giturl"
      open $giturl
    fi
  }
#
###