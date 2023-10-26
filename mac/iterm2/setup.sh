. ./mac/support/prompts.sh

pushd "./mac/iterm2" > /dev/null

DESTINATION="$(realpath $HOME/Library/Preferences)"

info "Updating iTerm2 configuration."
SOURCE="$(realpath .)"
find . -name "*.plist" | while read config; do
    ln -s "$SOURCE/$config" "$DESTINATION/$config"
done
success "iTerm2 configuration successfully updated."

popd > /dev/null