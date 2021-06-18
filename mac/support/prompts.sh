color() {
  local expression="$1";
  local color="$2";
  local prefix="$3";
  local suffix="$4";

  if ! [[ $color =~ '^[0-9]$' ]]; then
    case $(echo $color | tr '[:upper:]' '[:lower:]') in
      black) color=0 ;;
      red) color=1 ;;
      green) color=2 ;;
      yellow) color=3 ;;
      blue) color=4 ;;
      magenta) color=5 ;;
      cyan) color=6 ;;
      white|*) color=7 ;;
    esac
  fi

  tput bold;
  tput setaf "$color";
  echo "$prefix $expression $suffix";
  tput sgr0;
}

info() {
  color "$1" blue ">> " " <<"
}

success() {
  color "$1" green ">> " " <<"
}

warning() {
  color "$1" yellow ">> " " <<"
}

error() {
  color "$1" red ">> " " <<"
}
