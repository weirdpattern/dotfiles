#! /usr/bin/env sh

. ./mac/support/prompts.sh

info "Requesting sudo access in advance."
if sudo -v; then
  while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
  success "Sudo access granted."
else
  error "Sudo access denied. Please verify your credentials."
fi

info "Installing XCode command line utils."
if xcode-select --print-path &>/dev/null; then
  success "XCode command line utils already installed."
elif xcode-select --install &>/dev/null; then
  success "XCode command line utils successfully installed."
else
  warning "XCode command line utils couldn't be installed."
fi

info "Installing brew."
if command -v brew >/dev/null 2>&1; then
  success "Brew already installed."
elif /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" &>/dev/null; then
  success "Brew successfully installed."
else
  error "Brew couldn't be installed."
fi

./mac/orchestrator.sh

success "Setup has been successfully completed."
