#! /usr/bin/env sh

DIR=$(dirname "$0")
cd "$DIR"

. ../support/prompts.sh

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
  succes "Extras successfully installed."
done
