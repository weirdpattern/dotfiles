#!/bin/bash

# Request sudo access beforehand
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Source the common.sh file
[[ -e "$PWD/support/common.sh" ]] && source "$PWD/support/common.sh"

# Ignore errors
set +e

# Install brew if we don't have it
if [[ ! $(which "brew") ]]; then

  echo "Installing XCode Command Line Developer Tools..."
  xcode-select --install

  echo "Installing Homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

  echo "Installing Homebrew Cask…"
  brew install "brew-cask"

  echo "Installing Java…"
  brew cask install "java"

else

  echo "Updating Homebrew..."
  brew update
  brew upgrade

fi

# Check for any problem
brew doctor
brew prune

# Brews to be installed
brews=(
  p7zip
  ack
  bash
  bash-completion
  coreutils
  findutils
  python
  ruby
  perl
  vim
  wget
  node
  git
  git-extras
  ant
  gradle
  maven
)

# Install brew software
result=$(confirm "Do you want to install brew components?")
if [[ $result = 0 ]]; then
  echo ""
  echo "Installing brew software..."
  foreach "brew install" ${brews[@]}
  echo "Brew components installation completed"
fi

echo ""

####################################################################################

# Brews casks to be installed
casks=(
  alfred
  google-chrome
  intellij-idea
  webstorm
  pycharm
  rubymine
  appcode
  datagrip
  visual-studio-code
  dash
  1password
  hyper
  jing
)

# Install brew cask software
result=$(confirm "Do you want to install brew cask components?")
if [[ $result = 0 ]]; then
  echo ""
  echo "Installing brew cask software..."
  foreach "brew cask install --appdir='/Applications'" ${casks[@]}
  echo "Brew cask components installation completed"
fi

echo ""

####################################################################################

# Fonts to be installed
fonts=(
  font-source-code-pro
  font-roboto
  font-roboto-mono
)

# Install fonts
result=$(confirm "Do you want to install fonts?")
if [[ $result = 0 ]]; then
  # Tabs the required repositories
  brew tap caskroom/fonts

  echo ""
  echo "Installing fonts..."
  foreach "brew cask install" ${fonts[@]}
  echo "Fonts installation completed"
fi

echo ""

####################################################################################

result=$(confirm "Would you like to setup your environment?")
if [[ $result = 0 ]]; then
  echo ""
  echo "Creating repository folder"
  if [ ! -d ~/Repositories ]; then
    mkdir ~/Repositories
  fi

  cd ~/Repositories

  echo "Getting dotfiles from repository"
  git clone "https://github.com/ptrevinor/dotfiles.git"

  cd ~/Repositories/dotfiles
  bash setup.sh
fi

echo ""
