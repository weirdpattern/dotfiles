#! /usr/bin/env sh

DIR=$(dirname "$0")
cd "$DIR"

. ../support/prompts.sh

DESTINATION="$(realpath $HOME/Library/Preferences)"

info "Updating ManyTricks configuration."
SOURCE="$(realpath .)"
find . -name "*.plist" | while read config; do
    symlink "$SOURCE/$config" "$DESTINATION/$config"
done
success "ManyTricks configuration successfully updated."
