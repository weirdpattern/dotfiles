#!/bin/env bash

###########
# General #
###########
#
  # Allow aliases to be sudo
  alias sudo='sudo '
#
###

###############
# File System #
###############
#
  # Opens hosts file
  alias hosts='sudo $EDITOR /etc/hosts'

  # Show/hide hidden files in Finder
  alias show-files='defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder'
  alias hide-files='defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder'

  # Show/hide desktop icons
  alias show-desk='defaults write com.apple.finder CreateDesktop -bool true && killall Finder'
  alias hide-desk='defaults write com.apple.finder CreateDesktop -bool false && killall Finder'
#
###

##############
# Networking #
##############
#
  # Flush DNS cache
  alias flush-dns='dscacheutil -flushcache'

  # Gets the computer ip address
  alias ip='dig +short myip.opendns.com @resolver1.opendns.com'
#
###

#######################
# Terminal navigation #
#######################
#
  # Go back one level in windows format
  alias cd..='cd ..'

  # Go back one level and list content
  alias ..='back'

  # Go back two levels and list content
  alias ..2='back 2'

  # Go back three levels and list content
  alias ..3='back 3'

  # Go back four levels and list content
  alias ..4='back 4'
  
  # Go back five levels and list content
  alias ..5='back 5'

  # Go back to home and list content
  alias ~='cd ~; ls'

  # Go back to previous pwd and list content
  alias -- -='cd -; ls'
#
###

#######################
# Terminal operations #
#######################
#
  # mv explicit verbose
  alias mv='mv -v'
  
  # mk shortcut
  alias mk='mkdir -p'
  
  # mkdir explicit create path folders
  alias mkdir='mkdir -p'

  # rm explicit verbose
  alias rm='rm -v'

  # cp explicit verbose
  alias cp='cp -v'

  # List all files in long format using color.
  alias ls='ls -aoG'

  # List all directories in long format using color.
  alias lsd='ls -o | grep ^d'
  
  # Clear shorcuts
  alias cls='clear'
  alias clr='clear'
  alias clrsrc='clear'  

  # Exit and quit
  alias quit='/usr/bin/osascript -e "tell application \"$TERMINAL\" to quit";exit'
#
###

################
# Applications #
################
#
  # Git shortcut
  alias g='git'
  
  # Git Status shortcut
  alias gstat='git status'
  
  # Git redirect to root directory
  alias groot='[ ! -z `git rev-parse --show-cdup` ] && cd `git rev-parse --show-cdup`'

  # Cask shortcut
  alias cask='brew cask'  
#
###
