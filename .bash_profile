# Update Homebrew itself, upgrade all packages, remove dead symlinks, remove old versions
# of installed formulas, clean old downloads from cache, remove versions of formulas, which
# are downloaded, but not installed, check system for potential problems, remove cached
# Homebrew-Cask downloads
alias brewup='brew update; brew upgrade; brew prune; brew cleanup; brew doctor; brew cask cleanup'

# Remove bash history and exit bash shell
alias rmhis='rm .bash_history; history -c; logout'

# Easier navigation
alias ..="cd .."
alias ....="cd ../.."

# Shortcuts
alias p="cd ~/Projects"
alias d="cd ~/Desktop"

# Enable ANSI colors sequences to distinguish file types
export CLICOLOR=1

# Value of this variable describes what color to use for which attribute
export LSCOLORS=GxFxCxDxBxegedabagaced

# Color definitions
RED='\[\033[1;31m\]'
GREEN='\[\033[1;32m\]'
YELLOW='\[\033[1;33m\]'
PURPLE='\[\033[1;35m\]'
GRAY='\[\033[1;30m\]'
DEFAULT='\[\033[0m\]'

# Function which prints current Git branch name
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

# Set up prompt
PS1="${RED}\u" # Username
PS1+=" ${GRAY}• " # Separator
PS1+="${GREEN}\h" # Hostname
PS1+=" ${GRAY}• " # Seprataor
PS1+="${YELLOW}\w" # Working directory
PS1+=" ${GRAY}\$([[ -n \$(git branch 2> /dev/null) ]] && echo \"•\") " # Separator
PS1+="${PURPLE}\$(parse_git_branch)" # Git branch
PS1+="\n" # New line
PS1+="${GRAY}\$ " # Dollar sign
PS1+="${DEFAULT}" # Get back default color

export PS1;
