. ./mac/support/prompts.sh

pushd "./mac/zsh" > /dev/null

COMMENT=\#*

sudo -v

find * -name "*.list" | while read extras; do
  info "Installing extensions."
  while read command; do
    if [[ $command == $COMMENT ]]; then
      continue
    fi

    info "- Executing $command"
    eval ${command}
  done < "$extras"
  success "Extras successfully installed."
done

DESTINATION="$(realpath $HOME/.config/zsh)"

info "Copying ZSH configuration."
SOURCE="$(realpath ./.config/zsh)"
find . -name "*.zsh" | while read file; do
    ln -s "$SOURCE/$file" "$DESTINATION/$file"
done
success "ZSH configuration successfully copied."

DESTINATION="$(realpath $HOME)"

info "Copying ZSHRC configuration."
SOURCE="$(realpath .)"
find . -name ".zshrc" | while read file; do
    ln -s "$SOURCE/$file" "$DESTINATION/$file"
done
success "ZSHRC configuration successfully copied."

popd
