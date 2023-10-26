. ./mac/support/prompts.sh

info "Enable tap to click."
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

info "Enable bottom right corner to right click mapping."
defaults write com.aipple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true
defaults -currentHost write NSGlobalDomain com.apple.trackpad.trackpadCornerClickBehavior -int 1
defaults -currentHost write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool true

info "Disable natural scrolling."
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool true

info "Set sound quality for Bluetooth headphones/headsets."
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 4"

