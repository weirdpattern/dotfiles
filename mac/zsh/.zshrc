# Source the exports first
source $HOME/.config/zsh/env.zsh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="gruvbox"
SOLARIZED_THEME="dark"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  docker
  docker-compose
  dotnet
  dotenv
  gatsby
  git
  git-flow-avh
  git-prompt
  jsontools
  npm
  sudo
  yarn
  zsh-completions
  zsh-autosuggestions
  zsh-syntax-highlighting
)
echo $ZSH
# Source the needed files
source $ZSH/oh-my-zsh.sh

typeset -ga sources
sources+="$ZSH_CONFIG/env.zsh"
sources+="$ZSH_CONFIG/options.zsh"
sources+="$ZSH_CONFIG/functions.zsh"
sources+="$ZSH_CONFIG/aliases.zsh"

foreach file (`echo $sources`)
  if [[ -a $file ]]; then
    source $file
  fi
end
