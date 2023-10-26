. ./mac/support/prompts.sh

pushd "./mac/applications" > /dev/null

COMMENT=\#*

sudo -v

info "Installing brew applications."
brew bundle
success "Brew applications successfully installed."

find * -name "*.list" | while read extras; do
  info "Installing extras."
  while read command; do
    if [[ $command == $COMMENT ]]; then
      continue
    fi

    info "- Executing $command"
    eval ${command}
  done < "$extras"
  success "Extras successfully installed."
done

popd > /dev/null