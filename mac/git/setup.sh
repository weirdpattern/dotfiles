. ./mac/support/prompts.sh

DESTINATION="$(realpath ~)"

info "Updating git configuration."
SOURCE="$(realpath ../../shared/git)"
find . -name ".git*" | while read config; do
    fn=$(basename $config)
    ln -s "$SOURCE/$config" "$DESTINATION/$config"
done
success "Git configuration successfully updated."

info "Updating macOS specific git configuration."
SOURCE="$(realpath .)"
find . -name ".git*" | while read config; do
    fn=$(basename $config)
    ln -s "$SOURCE/$config" "$DESTINATION/$config"
done
success "Git macOS specific configuration successfully updated."