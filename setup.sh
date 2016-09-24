#!/bin/bash

# Request sudo access beforehand
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Source the common.sh file
[[ -e "$PWD/support/common.sh" ]] && source "$PWD/support/common.sh"

# Ignore errors
set +e

# Setups to be run after installation
setups=(
  $PWD/git/setup.sh
  $PWD/npm/setup.sh
  $PWD/vim/setup.sh
  $PWD/vscode/setup.sh
  $PWD/osx/setup.sh
)

# Run setup files
echo ""
echo "Setting up environment..." 
foreach "bash" ${setups[@]}
echo "Setup process completed"
echo ""