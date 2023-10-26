. ./mac/support/prompts.sh

info "Disable drive's head."
sudo pmset -a sms 0

info "Enable lid wake up."
sudo pmset -a lidwake 1

info "Enable automatic restart on power loss."
sudo pmset -a autorestart 1

info "Enable sleep display after 15 min."
sudo pmset -a displaysleep 15

info "Disable machine sleep while charging."
sudo pmset -c sleep 0

info "Enable machine sleep to 5 minutes while on battery."
sudo pmset -b sleep 5

info "Enable automatic restart on computer freeze."
sudo systemsetup -setrestartfreeze on

info "Disable hibernation."
sudo pmset -a hibernatemode 0