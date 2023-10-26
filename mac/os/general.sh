. ./mac/support/prompts.sh

info "Set identities to be stored in the KeyChain."
sudo ssh-add -K

info "Disable GateKeeper to allow smother app installation."
sudo spctl --master-disable

# %00 = enabled
# %01 = disabled
info "Disable the sound effects on boot."
sudo nvram StartupMute=%01 

# Blue     = 1
# Graphite = 6
info "Set the button, menu and windows general appearance to graphite."
defaults write NSGlobalDomain AppleAquaColorVariant -int 6

info "Set dark mode for menu bar and dock to dark."
defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"

# Red      = `1.000000 0.733333 0.721569`
# Orange   = `1.000000 0.874510 0.701961`
# Yellow   = `1.000000 0.937255 0.690196`
# Green    = `0.752941 0.964706 0.678431`
# Blue     = `0.847059 0.847059 0.862745`
# Purple   = `0.968627 0.831373 1.000000`
# Pink     = `0.968627 0.831373 1.000000`
# Brown    = `0.929412 0.870588 0.792157`
# Graphite = `0.847059 0.847059 0.862745`
info "Set the highlight color on the system to orange."
defaults write NSGlobalDomain AppleHighlightColor -string '1.000000 0.874510 0.701961'

# Small  = 1
# Medium = 2 
# Large  = 3
info "Set the sidebar icon size to small."
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 1

# Automatically based on mouse or trackpad = `Automatic`
# When scrolling                           = `WhenScrolling`
# Always                                   = `Always`
info "Set the scrollbar visibility to only activate when scrolling."
defaults write NSGlobalDomain AppleShowScrollBars -string 'WhenScrolling'

info "Disable the over-the-top focus ring animation."
defaults write NSGlobalDomain NSUseAnimatedFocusRing -bool false

info "Increase window resize speed for Cocoa applications."
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

info "Set the save panel to expand by default."
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

info "Set the print panel to expand by default."
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

info "Set save to disk by default (instead of iCloud)."
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

info "Set the printer app to quit once the print jobs complete."
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

info "Set number of recent items (Documents, Apps, and Servers)"
for category in 'applications' 'documents' 'servers'; do
  /usr/bin/osascript -e "tell application \"System Events\" to tell appearance preferences to set recent $category limit to 0"
done

info "Disable the 'Are you sure you want to open this application?' dialog."
defaults write com.apple.LaunchServices LSQuarantine -bool false

info "Remove duplicates in the “Open With” menu (also see 'lscleanup' alias)."
/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user

info "Display ASCII control characters using caret notation in standard text views."
defaults write NSGlobalDomain NSTextShowsControlCharacters -bool true

info "Set windows to close when quitting an application."
defaults write NSGlobalDomain NSQuitAlwaysKeepsWindows -bool false

info "Disable automatic termination of inactive apps."
defaults write NSGlobalDomain NSDisableAutomaticTermination -bool true

info "Disable crash reporter."
defaults write com.apple.CrashReporter DialogType -string "none"

info "Set Help Viewer windows to non-floating mode."
defaults write com.apple.helpviewer DevMode -bool true

info "Disable automatic capitalization."
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

info "Disable smart dashes."
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

info "Disable automatic period substitution."
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

info "Disable smart quotes."
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

info "Disable auto-correct."
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

info "Remove transparency."
defaults write com.apple.universalaccess reduceTransparency -bool true