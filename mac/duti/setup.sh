. ./mac/support/prompts.sh

pushd "./mac/duti" > /dev/null

info "Updating default applications with duti."
find * -not -name "setup.sh" -type f | while read application; do
  while read ext; do
    duti -s $application $ext all
  done < $application
done
success "Default applications successfully updated."

popd > /dev/null