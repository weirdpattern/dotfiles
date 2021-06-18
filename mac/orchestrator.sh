#! /usr/bin/env sh

DIR=$(dirname "$0")
cd "$DIR"

. utilities/setup.sh
. applications/setup.sh

find * -name "setup.sh" -not -wholename "[utilities|applications]*" | while read setup; do
  ./$setup
done
