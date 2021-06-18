# Creates backups of files or directors
function backup {
  if [[ -d $1 ]]; then
    zip -r $1-$(date +'%m%d%y%H%M').zip $1
  else
    cp -i $1 ${1%.*}-$(date +'%m%d%y%H%M').${1#*.}.bkp
  fi
}

# Moves an item to the trash
function trash {
  mv $1 ~/.Trash
}

# Opens the sandbox
function sandbox {
  if [[ "$1" ]]; then
    cd "$SANDBOX/$1"
  else
    cd "$SANDBOX"
  fi

  ll
}

# Opens the current git repository in a browser
function browse {
  local giturl=$(git config --get remote.origin.url | sed 's/git@/\/\//g' | sed 's/.git$//' | sed 's/https://g' | sed 's/:/\//g')
  if [[ $giturl == "" ]]; then
    echo "Not a git repository or no remote.origin.url is set."
  else
    local gitbranch=$(git rev-parse --abbrev-ref HEAD)
    local giturl="http:${giturl}"

    if [[ $gitbranch != "master" ]]; then
      local giturl="${giturl}/tree/${gitbranch}"
    fi

    echo "Opening $giturl"
    open $giturl
  fi
}
