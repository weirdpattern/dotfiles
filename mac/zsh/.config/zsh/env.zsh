# Set the sandbox
export SANDBOX="$HOME/Sandbox"

# Set the searchable PATH
export PATH=/usr/local/sbin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/.local/sbin:$PATH

# Set the ZSH and Oh my ZSH configuration
export ZSH="$HOME/.oh-my-zsh"
export ZSH_CONFIG="$HOME/.config/zsh"

# Set the editor
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR="vim"
else
  export EDITOR="mvim"
fi
