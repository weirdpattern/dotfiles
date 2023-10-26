. ./mac/support/prompts.sh

info "Disable animations."
defaults write com.apple.finder DisableAllAnimations -bool true

info "Set desktop as the default location for new finder windows."
defaults write com.apple.finder NewWindowTarget -string "PfDe"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"

info "Set desktop to show hard drives."
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true

info "Set desktop to hide external drives, mounted servers and removable media."
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowMountedServersOnDesktop -bool false
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool false

info "Enable hidden files."
defaults write com.apple.finder AppleShowAllFiles -bool true

info "Enable file extensions."
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

info "Enable status bar."
defaults write com.apple.finder ShowStatusBar -bool true

info "Enable path bar."
defaults write com.apple.finder ShowPathbar -bool true

info "Enabled POSIX path as window title."
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

info "Set folders to be on top when sorting by name."
defaults write com.apple.finder _FXSortFoldersFirst -bool true

info "Set search scope to current folder."
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

info "Disable the warning when changing a file extension."
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

info "Enable spring loading for directories."
defaults write NSGlobalDomain com.apple.springing.enabled -bool true

info "Set sprint loading delay for directories."
defaults write NSGlobalDomain com.apple.springing.delay -float 0

info "Disable creation of ,DS_Store files on network or USB volumes."
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

info "Disable disk image verification."
defaults write com.apple.frameworks.diskimages skip-verify -bool true
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

info "Set finder to open a new window when a volume is mounted."
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

# icnv
# clmv
# Flmv
# Nlsv
info "Set list view in all Finder windows by default."
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

info "Disable the warning before emptying the Trash."
defaults write com.apple.finder WarnOnEmptyTrash -bool false

info "Set the ~/Library folder to be displayed."
chflags nohidden ~/Library && xattr -d com.apple.FinderInfo ~/Library

info "Set the /Volumnes folder to be displayed."
sudo chflags nohidden /Volumes

info "Expand general, open with and sharing & permissions on files."
defaults write com.apple.finder FXInfoPanesExpanded -dict \
  General -bool true \
  OpenWith -bool true \
  Privileges -bool true
