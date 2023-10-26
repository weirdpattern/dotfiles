. ./mac/support/prompts.sh

info "Set password to be required immediately after sleep or screen saver begins."
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# PNG
# BMP
# GIF
# JPG
# PDF
# TIFF
info "Set PNG format for screenshots."
defaults write com.apple.screencapture type -string "png"

info "Disable shadow in screenshots."
defaults write com.apple.screencapture disable-shadow -bool true

info "Enable subpixel font rendering on non-Apple LCDs."
defaults write NSGlobalDomain AppleFontSmoothing -int 1

info "Enable HiDPI display modes (requires restart)."
sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true

if [[ ! -d "${HOME}/Screenshots" ]]; then
  sudo mkdir -p "${HOME}/Screenshots"
fi  
  
sudo chmod 777 "${HOME}/Screenshots"
  
info "Set desktop as the save location for screenshots."
defaults write com.apple.screencapture location -string "${HOME}/Screenshots"