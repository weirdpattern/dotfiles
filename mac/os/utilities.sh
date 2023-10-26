. ./mac/support/prompts.sh

info "Disable time machine from prompting to use new hard drives as backup volume."
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

info "Set the main window to show when launching activity monitor."
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

info "Set CPU visualization usage in the activity monitor dock icon."
defaults write com.apple.ActivityMonitor IconType -int 5

info "Set activity monitor to show all processes."
defaults write com.apple.ActivityMonitor ShowCategory -int 0

info "Set activity monitor results to be sorted by CPU usage."
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0

info "Enable the automatic update check on mac app store."
defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true

info "Set software updates checks every 3 days, not just once per week."
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 3

info "Set newly available updates to download in background."
defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1

info "Set system data files & security updates to be installed."
defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1

info "Set auto-update on."
defaults write com.apple.commerce AutoUpdate -bool true

info "Set app store to reboot machine on macOS updates."
defaults write com.apple.commerce AutoUpdateRestartRequired -bool true

info "Disable photos from opening automatically when devices are plugged in."
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

info "Disable smart quotes on messages."
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticQuoteSubstitutionEnabled" -bool false

info "Disable continuous spell checking on messages."
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "continuousSpellCheckingEnabled" -bool false

info "Set the system-native print preview dialog on chrome."
defaults write com.google.Chrome DisablePrintPreview -bool true

info "Set print dialog to be expanded by default."
defaults write com.google.Chrome PMPrintingExpandedStateForPrint2 -bool true

info "Set the system-native print preview dialog on brave."
defaults write com.brave.Browser DisablePrintPreview -bool true

