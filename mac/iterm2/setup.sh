#! /usr/bin/env sh

DIR=$(dirname "$0")
cd "$DIR"

. ../support/prompts.sh

DESTINATION="$(realpath $HOME/Library/Preferences)"

info "Updating iTerm2 configuration."
SOURCE="$(realpath .)"
find . -name "*.plist" | while read config; do
    symlink "$SOURCE/$config" "$DESTINATION/$config"
done
success "iTerm2 configuration successfully updated."
