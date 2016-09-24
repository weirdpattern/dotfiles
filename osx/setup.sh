#!/usr/bin/env bash

sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

############
# Terminal #
############
#
  echo ""
  echo "Adjusting Terminal preferences"
  
  # Change the encoding to UTF-8
  echo "    defaults write com.apple.terminal StringEncodings -array 4"  
  defaults write com.apple.terminal StringEncodings -array 4
  
  # Change the terminal theme to Pro
  echo "    defaults write com.apple.Terminal 'Default Window Settings' -string 'Pro'"
  defaults write com.apple.Terminal "Default Window Settings" -string "Pro"
  
  echo "    defaults write com.apple.Terminal 'Startup Window Settings' -string 'Pro'"
  defaults write com.apple.Terminal "Startup Window Settings" -string "Pro"  
#
###

##########
# Finder #
##########
#
  echo ""
  echo "Adjusting Finder preferences"
  
  # Show external hard drives on desktop
  echo "    defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true"
  defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
  
  # Disable window animations and Get Info animations
  echo "    defaults write com.apple.finder DisableAllAnimations -bool true"
  defaults write com.apple.finder DisableAllAnimations -bool true

  # Show all filename extensions
  echo "    defaults write NSGlobalDomain AppleShowAllExtensions -bool true"
  defaults write NSGlobalDomain AppleShowAllExtensions -bool true

  # Show status bar
  echo "    defaults write com.apple.finder ShowStatusBar -bool true"
  defaults write com.apple.finder ShowStatusBar -bool true

  # Show path bar
  echo "    defaults write com.apple.finder ShowPathbar -bool true"
  defaults write com.apple.finder ShowPathbar -bool true
  
  # Disable change extension warning
  echo "    defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false"
  defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

  # Sets the default view style to LIST
  echo "    defaults write com.apple.finder FXPreferredViewStyle Nlsv"
  defaults write com.apple.finder FXPreferredViewStyle Nlsv

  # Do not write .DS_Store in external drives
  echo "    defaults write com.apple.finder FXPreferredViewStyle Nlsv"
  defaults write com.apple.finder FXPreferredViewStyle Nlsv

  # Show the $HOME/Library folder
  echo "    chflags nohidden $HOME/Library"
  chflags nohidden $HOME/Library
  
  # Change Desktop arrange by style to grid
  echo "    /usr/libexec/PlistBuddy -c 'Set :DesktopViewSettings:IconViewSettings:arrangeBy grid' '$HOME/Library/Preferences/com.apple.finder.plist' &>/dev/null"    
  /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" "$HOME/Library/Preferences/com.apple.finder.plist" &>/dev/null
  
  echo "    /usr/libexec/PlistBuddy -c 'Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid' '$HOME/Library/Preferences/com.apple.finder.plist' &>/dev/null" 
  /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" "$HOME/Library/Preferences/com.apple.finder.plist" &>/dev/null
  
  echo "    /usr/libexec/PlistBuddy -c 'Set :StandardViewSettings:IconViewSettings:arrangeBy grid' '$HOME/Library/Preferences/com.apple.finder.plist' &>/dev/null"
  /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" "$HOME/Library/Preferences/com.apple.finder.plist" &>/dev/null
  
  # Change Desktop grid spacing to 50
  echo "    /usr/libexec/PlistBuddy -c 'Set :DesktopViewSettings:IconViewSettings:gridSpacing 50' '$HOME/Library/Preferences/com.apple.finder.plist' &>/dev/null"     
  /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:gridSpacing 50" "$HOME/Library/Preferences/com.apple.finder.plist" &>/dev/null
  
  echo "    /usr/libexec/PlistBuddy -c 'Set :FK_StandardViewSettings:IconViewSettings:gridSpacing 50' '$HOME/Library/Preferences/com.apple.finder.plist' &>/dev/null"  
  /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:gridSpacing 50" "$HOME/Library/Preferences/com.apple.finder.plist" &>/dev/null
  
  echo "    /usr/libexec/PlistBuddy -c 'Set :StandardViewSettings:IconViewSettings:gridSpacing 50' '$HOME/Library/Preferences/com.apple.finder.plist' &>/dev/null" 
  /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:gridSpacing 50" "$HOME/Library/Preferences/com.apple.finder.plist" &>/dev/null
  
  # Change Desktop icon size to 32
  echo "    /usr/libexec/PlistBuddy -c 'Set :DesktopViewSettings:IconViewSettings:iconSize 32' '$HOME/Library/Preferences/com.apple.finder.plist' &>/dev/null"
  /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:iconSize 32" "$HOME/Library/Preferences/com.apple.finder.plist" &>/dev/null
  
  echo "    /usr/libexec/PlistBuddy -c 'Set :FK_StandardViewSettings:IconViewSettings:iconSize 32' '$HOME/Library/Preferences/com.apple.finder.plist' &>/dev/null"
  /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:iconSize 32" "$HOME/Library/Preferences/com.apple.finder.plist" &>/dev/null
  
  echo "    /usr/libexec/PlistBuddy -c 'Set :StandardViewSettings:IconViewSettings:iconSize 32' '$HOME/Library/Preferences/com.apple.finder.plist' &>/dev/null"
  /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:iconSize 32" "$HOME/Library/Preferences/com.apple.finder.plist" &>/dev/null
#
###

########
# Dock #
########
#
  echo ""
  echo "Adjusting Dock preferences"
  
  # Automatically hide and show the Dock
  echo "    defaults write com.apple.dock autohide -bool true"
  defaults write com.apple.dock autohide -bool true

  # Set the icon size of Dock items to 32 pixels
  echo "    defaults write com.apple.dock tilesize -int 32"
  defaults write com.apple.dock tilesize -int 32

  # Change minimize/maximize window effect
  echo "    defaults write com.apple.dock mineffect -string scale"
  defaults write com.apple.dock mineffect -string scale

  # Remove the autohide delay
  echo "    defaults write com.apple.Dock autohide-delay -float 0"
  defaults write com.apple.dock autohide-delay -float 0
  
  # Change the auto hide time
  echo "    defaults write com.apple.dock autohide-time-modifier -float 0"
  defaults write com.apple.dock autohide-time-modifier -float 0

  # Minimize windows into their application’s icon
  echo "    defaults write com.apple.dock minimize-to-application -bool true"
  defaults write com.apple.dock minimize-to-application -bool true

  # Enable spring loading for all Dock items
  echo "    defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true"
  defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true

  # Show indicator lights for open applications in the Dock
  echo "    defaults write com.apple.dock show-process-indicators -bool true"
  defaults write com.apple.dock show-process-indicators -bool true

  # Remove all icons from the dock
  echo "    defaults delete com.apple.dock persistent-apps"
  defaults delete com.apple.dock persistent-apps
  
  # Reduce the expose animation duration
  echo "    defaults write com.apple.dock expose-animation-duration -float 0.1"
  defaults write com.apple.dock expose-animation-duration -float 0.1
  
  # Disable animations
  echo "    defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false"
  defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false

  # Groups apps in dock icon
  echo "    defaults write com.apple.dock expose-group-by-app -bool true"
  defaults write com.apple.dock expose-group-by-app -bool true
#
###

#############
# Launchpad #
#############
#
  echo ""
  echo "Adjusting Launchpad preferences"
  
  # Change the number of rows to 6
  echo "    defaults write com.apple.dock springboard-rows -int 6"
  defaults write com.apple.dock springboard-rows -int 6
  
  # Change the number of columns to 9
  echo "    defaults write com.apple.dock springboard-columns -int 9"
  defaults write com.apple.dock springboard-columns -int 9
  
  # Removes the effects when opening and closing
  echo "    defaults write com.apple.dock springboard-show-duration -int 0"
  defaults write com.apple.dock springboard-show-duration -int 0
  
  echo "    defaults write com.apple.dock springboard-hide-duration -int 0"
  defaults write com.apple.dock springboard-hide-duration -int 0
  
  # Reduce animation duration
  echo "    defaults write com.apple.dock expose-animation-duration -float 0.1"
  defaults write com.apple.dock expose-animation-duration -float 0.1
  
  # Resets the launch pad
  echo "    defaults write com.apple.dock ResetLaunchPad -bool TRUE"
  defaults write com.apple.dock ResetLaunchPad -bool TRUE  

  # Remove applications
  sqlite3 $(sudo find /private/var/folders -name com.apple.dock.launchpad)/db/db "DELETE FROM apps"
#
###

#############
# Spotlight #
#############
#
  echo ""
  echo "Changing Spotlight preferences"
  
  echo "    defaults write com.apple.spotlight orderedItems -array"
  defaults write com.apple.spotlight orderedItems -array \
    '{"enabled" = 1;"name" = "APPLICATIONS";}' \
    '{"enabled" = 1;"name" = "SYSTEM_PREFS";}' \
    '{"enabled" = 1;"name" = "DIRECTORIES";}' \
    '{"enabled" = 1;"name" = "DOCUMENTS";}' \
    '{"enabled" = 0;"name" = "FONTS";}' \
    '{"enabled" = 0;"name" = "PDF";}' \
    '{"enabled" = 0;"name" = "MESSAGES";}' \
    '{"enabled" = 0;"name" = "CONTACT";}' \
    '{"enabled" = 0;"name" = "EVENT_TODO";}' \
    '{"enabled" = 0;"name" = "IMAGES";}' \
    '{"enabled" = 0;"name" = "BOOKMARKS";}' \
    '{"enabled" = 0;"name" = "MUSIC";}' \
    '{"enabled" = 0;"name" = "MOVIES";}' \
    '{"enabled" = 0;"name" = "PRESENTATIONS";}' \
    '{"enabled" = 0;"name" = "SPREADSHEETS";}' \
    '{"enabled" = 0;"name" = "SOURCE";}' \
    '{"enabled" = 0;"name" = "MENU_DEFINITION";}' \
    '{"enabled" = 0;"name" = "MENU_OTHER";}' \
    '{"enabled" = 0;"name" = "MENU_CONVERSION";}' \
    '{"enabled" = 0;"name" = "MENU_EXPRESSION";}' \
    '{"enabled" = 0;"name" = "MENU_WEBSEARCH";}' \
    '{"enabled" = 0;"name" = "MENU_SPOTLIGHT_SUGGESTIONS";}'
    
  echo "    sudo mdutil -i on / &>/dev/null"  
  sudo mdutil -i on / &>/dev/null    
#
###

##########
# Chrome #
##########
#
  echo ""
  echo "Adjusting Chrome preferences"
  
  # Use chrome print preview
  echo "    defaults write com.google.Chrome DisablePrintPreview -bool true"
  defaults write com.google.Chrome DisablePrintPreview -bool true
  
  echo "    defaults write com.google.Chrome.canary DisablePrintPreview -bool true"
  defaults write com.google.Chrome.canary DisablePrintPreview -bool true
  
  # Disable back and forward os x trackpad navigation
  echo "    defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false"
  defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false
  
  echo "    defaults write com.google.Chrome.canary AppleEnableSwipeNavigateWithScrolls -bool false"
  defaults write com.google.Chrome.canary AppleEnableSwipeNavigateWithScrolls -bool false
#
###

######################
# System preferences #
######################
#
  echo ""
  echo "Adjusting system preferences"
  
  # Expands the save dialog by default
  echo "    defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true"
  defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
  
  # Expands the print dialog by default
  echo "    defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true"
  defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
  
  echo "    defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true"
  defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true
  
  # Quits the print dialog after printing
  echo "    defaults write com.apple.print.PrintingPrefs 'Quit When Finished' -bool true"
  defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true
  
  # Change the software update from 1 week to 1 day
  echo "    defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1"
  defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1
  
  # Do not open Photos app when plugin an external drive
  echo "    defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true"
  defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true
  
  # Disable auto correct
  echo "    defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false"
  defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
  
  # Changes the screen capture save location
  if [[ ! -d "${HOME}/Screenshots" ]]; then
    sudo mkdir -p "${HOME}/Screenshots"
  fi  
  
  # Granting access
  sudo chmod 777 "${HOME}/Screenshots"
  
  # Change screenshot location
  echo "    defaults write com.apple.screencapture location -string "${HOME}/Screenshots""
  defaults write com.apple.screencapture location -string "${HOME}/Screenshots"
  
  # Show crash reports as notifications    
  echo "    defaults write com.apple.CrashReporter UseUNC 1"
  defaults write com.apple.CrashReporter UseUNC 1
  
  # Disable panel animations
  echo "    defaults write -g QLPanelAnimationDuration -float 0"
  defaults write -g QLPanelAnimationDuration -float 0
  
  # Improves performance
  echo "    /System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user"
  /System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user  
#
###

#################
# Input sources #
#################
#
  echo ""
  echo "Adjusting Keyboard, Trackpad and Mouse settings"
  
  # Changes the speed of the trackpad
  echo "    defaults write -g com.apple.trackpad.scaling 2"
  defaults write -g com.apple.trackpad.scaling 2
  
  # Changes the speed of the mouse
  echo "    defaults write -g com.apple.mouse.scaling 2.5"
  defaults write -g com.apple.mouse.scaling 2.5
  
  # Disable the keyboard backlight
  echo "    defaults write com.apple.BezelServices kDim -bool false"
  defaults write com.apple.BezelServices kDim -bool false
  
  # Keyboard Tab enabled even in modal dialogs
  echo "    defaults write NSGlobalDomain AppleKeyboardUIMode -int 3"
  defaults write NSGlobalDomain AppleKeyboardUIMode -int 3
  
  # Enables the tap to click  
  echo "    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true"
  defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
  
  echo "    defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1"
  defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
  
  echo "    defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1"
  defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
#
###

###########
# Display #
###########
#
  echo ""
  echo "Adjusting display preferences"
  
  # Removes transparency of the menu bar 
  echo "    defaults write com.apple.universalaccess reduceTransparency -bool true"
  defaults write com.apple.universalaccess reduceTransparency -bool true
  
  # Request password after screen saver is on
  echo "    defaults write com.apple.screensaver askForPassword -int 1"
  defaults write com.apple.screensaver askForPassword -int 1  
  
  echo "    defaults write com.apple.screensaver askForPasswordDelay -int 0"
  defaults write com.apple.screensaver askForPasswordDelay -int 0
#
###  

############
# Hardware #
############
#
  echo ""
  echo "Adjusting hardware preferences"
  
  echo "    sudo pmset -a sms 0"
  sudo pmset -a sms 0
#
###

echo ""

# Source the common.sh file
[[ -e "${0%/*}/../support/common.sh" ]] && source "${0%/*}/../support/common.sh"

# Create the symlinks
echo "Copying settings ${0%/*}/.bash_aliases -> $HOME/.bash_aliases"
cp -fi "${0%/*}/.bash_aliases" "$HOME/.bash_aliases"

echo "Copying settings ${0%/*}/.bash_exports -> $HOME/.bash_exports"
cp -fi "${0%/*}/.bash_exports" "$HOME/.bash_exports"

echo "Copying settings ${0%/*}/.bash_functions -> $HOME/.bash_functions"
cp -fi "${0%/*}/.bash_functions" "$HOME/.bash_functions"

echo "Copying settings ${0%/*}/.bash_prompt -> $HOME/.bash_prompt"
cp -fi "${0%/*}/.bash_prompt" "$HOME/.bash_prompt"

echo "Copying settings ${0%/*}/.bash_profile -> $HOME/.bash_profile"
cp -fi "${0%/*}/.bash_profile" "$HOME/.bash_profile"

echo "Copying settings ${0%/*}/.bashrc -> $HOME/.bashrc"
cp -fi "${0%/*}/.bashrc" "$HOME/.bashrc"

echo "Copying $PWD/.bash_overrides -> $HOME/.bash_overrides"
cp -fi "${0%/*}/.bash_overrides" "$HOME/.bash_overrides" 

# Restart the applications
read -p "Press enter to complete the installation"
find $HOME/Library/Application\ Support/Dock -name "*.db" -maxdepth 1 -delete
for app in "Activity Monitor" "Address Book" "Calendar" "Contacts" "cfprefsd" \
  "Dock" "Finder" "SystemUIServer" "Terminal" ; do
  killall "${app}" > /dev/null 2>&1
done