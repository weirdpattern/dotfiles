. ./mac/utilities/setup.sh
. ./mac/applications/setup.sh

find . -name "setup.sh" -type f -not -path "*/utilities/*" -not -path "*/applications/*" | while read setup; do
  ./$setup
done
