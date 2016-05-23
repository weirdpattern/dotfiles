#!/usr/bin/env bash

sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Source the common.sh file
[[ -e "${0%/*}/../support/common.sh" ]] && source "${0%/*}/../support/common.sh"

# Check if application exists
if [[ $(which "vim") ]] ; then
  
  # Create the symlinks
  echo "Copying settings ${0%/*}/.vimrc -> $HOME/.vimrc"
  cp -fi "${0%/*}/.vimrc" "$HOME/.vimrc"

fi