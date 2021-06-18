#! /usr/bin/env sh

DIR=$(dirname "$0")
cd "$DIR"

. ../support/prompts.sh

sudo -v

info "Update computer name."
sudo scutil --set ComputerName "Cerebellum"
sudo scutil --set LocalHostName "Cerebellum"
sudo scutil --set HostName "Cerebellum"
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "Cerebellum"
success "Computer name updated."

info "Update macOS defaults."
source $DIR/general.sh
source $DIR/dock.sh
source $DIR/spotlight.sh
source $DIR/finder.sh
source $DIR/utilities.sh
source $DIR/screen.sh
source $DIR/energy.sh
source $DIR/inputs.sh
success "macOS defaults updated."