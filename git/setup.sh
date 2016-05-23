#!/usr/bin/env bash

sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Source the common.sh file
[[ -e "${0%/*}/../support/common.sh" ]] && source "${0%/*}/../support/common.sh"

# Check if application exists
if [[ $(which "git") ]] ; then  
  
  # Copy files that cannot be symlinked
  echo "Copying ${0%/*}/.gitconfig -> $HOME/.gitconfig"
  cp -fi "${0%/*}/.gitconfig" "$HOME/.gitconfig"
  
  echo "Copying ${0%/*}/.gitoverrides -> $HOME/.gitoverrides"
  cp -fi "${0%/*}/.gitoverrides" "$HOME/.gitoverrides"
  
fi