# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# --------------------------- Paths ------------------------------------
# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Homebrew path
export PATH="/usr/local/sbin:$PATH"

# curl path
export PATH="/usr/local/opt/curl/bin:$PATH"

# nvm path
export NVM_DIR="$HOME/.nvm"
source $(brew --prefix nvm)/nvm.sh

# pyenv init
eval "$(pyenv init -)"

# Python 3 path (use only without pyenv)
# export PATH="/usr/local/opt/python/libexec/bin:$PATH"

# Ruby path
export PATH="/usr/local/opt/ruby/bin:$PATH"
export PATH="$(gem environment gemdir)/bin:$PATH"

# Support 256 colors path
export TERM="xterm-256color"

# ----------------------------- Plugins ---------------------------------------
# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  colored-man-pages
  extract
  fast-syntax-highlighting
  osx
  zsh-autosuggestions
  zsh-completions
  zsh_reload
)

# Homebrew Command Not Found
if brew command command-not-found-init > /dev/null 2>&1; then eval "$(brew command-not-found-init)"; fi

# Homebrew Shell Completion
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi

source $ZSH/oh-my-zsh.sh

# --------------------------- Aliases ----------------------------------
# Update Homebrew and Cask formulaes
# Include -f to update apps that are marked as latest
alias update="brew update && brew upgrade && brew cu --all"

# Cleanup Homebrew and Cask cache
alias cleanup="brew cleanup"

# Update macOS using Command Line Software Update Tool
alias macupdate="sudo softwareupdate -ia"

# Undo the last commit
alias uncommit="git reset HEAD~1"

# Copy SSH
alias copyssh="pbcopy < ~/.ssh/id_ed25519.pub | echo '=> Public key copied to pasteboard.'"

# Open .zshrc in VSCode
alias zshconfig="code ~/.zshrc"

# ------------------------------ Theme ----------------------------------------
# Starship ZSH theme
# The minimal, blazing-fast, and infinitely customizable prompt for any shell!
# Check out https://starship.rs for more details
eval "$(starship init zsh)"

# Starship path to load .config
export PATH="/usr/local/opt/starship/bin:$PATH"
