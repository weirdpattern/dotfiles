. ./mac/support/prompts.sh

info "Enable highlight hover effect for the grid view of a stack."
defaults write com.apple.dock mouse-over-hilite-stack -bool true

info "Set the icon size of Dock items to 32 pixels."
defaults write com.apple.dock tilesize -int 32

# genie
# suck
# scale
info "Change minimize/maximize window effect - genie, suck, or scale."
defaults write com.apple.dock mineffect -string "suck"

info "Disable dock magnification."
defaults write com.apple.dock magnification -bool false

# left
# bottom
# right
info "Set the dock position on screen."
defaults write com.apple.dock orientation -string "bottom"

# start
# middle
# end
info "Set the dock pinning."
defaults write com.apple.dock pinning -string 'middle'

info "Enable double-click a window's title bar to minimize."
defaults write NSGlobalDomain AppleMiniaturizeOnDoubleClick -bool true

info "Set windows to minimize into their application's icon."
defaults write com.apple.dock minimize-to-application -bool true

info "Disable spring loading for all Dock items."
defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool false

info "Enable indicator lights for open applications."
defaults write com.apple.dock show-process-indicators -bool true

info "Set the doc transparency."
defaults write com.apple.dock hide-mirror -bool true

info "Wipe all app icons from the dock."
defaults write com.apple.dock persistent-apps -array ""

info "Show only open applications in the dock."
defaults write com.apple.dock static-only -bool true

info "Disable animation while opening applications from the dock."
defaults write com.apple.dock launchanim -bool false

info "Set mission control animation speed."
defaults write com.apple.dock expose-animation-duration -float 0.1

info "Set grouping on windows by application in dock."
defaults write com.apple.dock expose-group-by-app -bool true

info "Disable dashboard."
defaults write com.apple.dashboard mcx-disabled -bool true

info "Don;t show dashboard as a space."
defaults write com.apple.dock dashboard-in-overlay -bool true

info "Don't automatically rearrange Spaces based on most recent use."
defaults write com.apple.dock mru-spaces -bool false

info "Set the auto-hiding dock delay."
defaults write com.apple.dock autohide-delay -float 0

info "Disable the animation when hiding/showing the dock."
defaults write com.apple.dock autohide-time-modifier -float 0

info "Set the dock to automatically hide and show."
defaults write com.apple.dock autohide -bool true

info "Set hidden applications translucent in the dock."
defaults write com.apple.dock showhidden -bool true

info "Disable recent applications in dock."
defaults write com.apple.dock show-recents -bool false

#  0 = no-op
#  2 = Mission Control
#  3 = Show application windows
#  4 = Desktop
#  5 = Start screen saver
#  6 = Disable screen saver
#  7 = Dashboard
# 10 = Put display to sleep
# 11 = Launchpad
# 12 = Notification Center

# Top left screen corner → Application Windows
defaults write com.apple.dock wvous-tl-corner -int 0
defaults write com.apple.dock wvous-tl-modifier -int 0

# Top right screen corner → Desktop
defaults write com.apple.dock wvous-tr-corner -int 0
defaults write com.apple.dock wvous-tr-modifier -int 0

# Bottom right screen corner → Desktop
defaults write com.apple.dock wvous-br-corner -int 4
defaults write com.apple.dock wvous-br-modifier -int 0

# Bottom left screen corner → Misson Control
defaults write com.apple.dock wvous-bl-corner -int 2
defaults write com.apple.dock wvous-bl-modifier -int 0