alias cat="bat --paging=never"
alias preview="bat"

alias -g -- -h="-h 2>&1 | bat --language=help --style=plain"
alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'

help() {
  "$@" --help 2>&1 | bat --language=help --style=plain
}