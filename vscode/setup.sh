#!/usr/bin/env bash

sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Source the common.sh file
[[ -e "${0%/*}/../support/common.sh" ]] && source "${0%/*}/../support/common.sh"
  
# Check if directory exists
if [[ -d "$HOME/Library/Application Support/Code/User/" ]]; then

  # Create the symlink
  echo "Copying settings ${0%/*}/settings.json -> $HOME/Library/Application Support/Code/User/settings.json"
  cp -fi "${0%/*}/settings.json" "$HOME/Library/Application Support/Code/User/settings.json"
        
fi