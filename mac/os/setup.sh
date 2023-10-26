. ./mac/support/prompts.sh

pushd "./mac/os" > /dev/null

sudo -v

info "Update computer name."
sudo scutil --set ComputerName "Cerebellum"
sudo scutil --set LocalHostName "Cerebellum"
sudo scutil --set HostName "Cerebellum"
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "Cerebellum"
success "Computer name updated."

info "Update macOS defaults."
source ./general.sh
source ./dock.sh
source ./spotlight.sh
source ./finder.sh
source ./utilities.sh
source ./screen.sh
source ./energy.sh
source ./inputs.sh
success "macOS defaults updated."

popd > /dev/null