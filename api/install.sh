#!/bin/bash

source ../bootstrap.sh
source ./brew.sh
source ./npm.sh

# Clear the terminal screen
clear

echo "Welcome to the installer!"
echo -e "First, introduce your password to execute all the commands as super user.$NEW_LINE"
echo -e "${RED}${BOLD}Important:$DEFAULT You can be asked more times for password during the process."
echo -e "Also, make sure that You are logged in to the Mac App Store.$NEW_LINE"

# Prompt user for password
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

#----------------------------
# Homebrew
#----------------------------

if hash brew 2>/dev/null; then
  IS_HOMEBREW_INSTALLED=true
fi

if $IS_HOMEBREW_INSTALLED; then
  echo "${ARROW} Homebrew already installed!"
else
  read -ep "${ARROW} Install Homebrew and update it? [y/n]: "

  if [ "$REPLY" == "y" ]; then
    echo "${ARROW} Installing Homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

    echo "${ARROW} Updating Homebrew formulas..."
    brew update
    brew upgrade

    IS_HOMEBREW_INSTALLED=true
  fi
fi

#----------------------------
# Git
#----------------------------

if $IS_HOMEBREW_INSTALLED; then
  read -p "${ARROW} Install latest Git version via Homebrew? [y/n]: "

  if [ "$REPLY" == "y" ]; then
    echo "${ARROW} Installing Git..."
    brew install git
  fi
fi

#----------------------------
# .bash_profile
#----------------------------

read -p "${ARROW} Configure .bash_profile? [y/n]: "

if [ "$REPLY" == "y" ]; then
  echo "${ARROW} Configuring .bash_profile..."
  cp .bash_profile ~ 
fi

#----------------------------
# Application bundle
#----------------------------

if $IS_HOMEBREW_INSTALLED; then
  read -p "${ARROW} Install bundle of applications via Homebrew-Cask? [y/n]: "

  if [ "$REPLY" == "y" ]; then
    echo "${ARROW} Installing applications..."
    install_bundle

    open /Applications/Flux.app
    open /Applications/Spectacle.app
    open /Applications/KeepingYouAwake.app
  fi
fi

#----------------------------
# Terminal profile
#----------------------------

read -p "${ARROW} Configure Terminal profile? [y/n]: "

if [ "$REPLY" == "y" ]; then
  echo -e "\033[1;33mNote:\033[0m New Terminal window opened. Click 'Shell' > 'Use settings as default' to use it as default profile."
  open ./Flat.terminal
fi

#----------------------------
# Node Version Manager
#----------------------------

if ! [ -x "$(command -v nvm)" ]; then
  IS_NVM_INSTALLED=true
fi

if $IS_NVM_INSTALLED; then
  echo "${ARROW} Node Version Manager already installed!"
else
  read -p "${ARROW} Install nvm (Node Version Manager)? [y/n]: "

  if [ "$REPLY" == "y" ]; then
    echo "${ARROW} Installing Node Version Manager..."
    curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
    source ~/.bash_profile

    IS_NVM_INSTALLED=true
  fi
fi

#----------------------------
# Node.js
#----------------------------

if hash node 2>/dev/null; then
  IS_NODE_INSTALLED=true
fi

if $IS_NODE_INSTALLED; then
  echo "${ARROW} Node.js already installed!"
else
  if [ $IS_NVM_INSTALLED == true ]; then
    read -p "${ARROW} Install latest LTS version of Node.js? [y/n]: "

    if [ "$REPLY" == "y" ]; then
      echo "${ARROW} Installing Node.js..."
      nvm install --lts

      IS_NODE_INSTALLED=true
    fi
  fi
fi

#----------------------------
# npm packages
#----------------------------

if $IS_NODE_INSTALLED; then
  read -p "${ARROW} Install bundle of npm packages? [y/n]: "

  if [ "$REPLY" == "y" ]; then
    echo "${ARROW} Installing npm packages.."
    install_npm_packages
  fi
fi

#----------------------------
# VS Code extensions
#----------------------------

if hash code 2>/dev/null; then
  IS_VSCODE_INSTALLED=true
fi

if $IS_VSCODE_INSTALLED; then
  read -p "${ARROW} Install bundle of Visual Studio Code extensions? [y/n]: "

  if [ "$REPLY" == "y" ]; then
    echo "${ARROW} Installing Visual Studio Code extensions..."
    code --install-extension CoenraadS.bracket-pair-colorizer --install-extension PKief.material-icon-theme --install-extension alefragnani.project-manager --install-extension christian-kohler.path-intellisense --install-extension dbaeumer.vscode-eslint --install-extension formulahendry.auto-rename-tag --install-extension mrmlnc.vscode-scss --install-extension msjsdiag.debugger-for-chrome --install-extension techer.open-in-browser --install-extension aaron-bond.better-comments --install-extension kamikillerto.vscode-colorize
  fi
fi

#----------------------------
# VS Code settings
#----------------------------

if $IS_VSCODE_INSTALLED; then
  read -p "${ARROW} Configure Visual Studio Code settings? [y/n]: "

  if [ "$REPLY" == "y" ]; then
    echo "${ARROW} Configuring Visual Studio Code..."
    cp settings.json /Users/${USER}/Library/Application\ Support/Code/User
  fi
fi

#----------------------------
# VS Code snippets
#----------------------------

if $IS_VSCODE_INSTALLED; then
  read -p "${ARROW} Configure Visual Studio Code snippets? [y/n]: "

  if [ "$REPLY" == "y" ]; then
    echo "${ARROW} Configuring Visual Studio Code snippets..."
    cp snippets.code-snippets /Users/${USER}/Library/Application\ Support/Code/User/snippets
  fi
fi

#----------------------------
# .gitconfig
#----------------------------

read -p "${ARROW} Configure .gitconfig? [y/n]: "

if [ "$REPLY" == "y" ]; then
  echo "${ARROW} Configuring .gitconfig..."
  cp .gitconfig ~
fi

#----------------------------
# Spectacle shortcuts
#----------------------------

if [ -d /Applications/Spectacle.app/ ]; then
  IS_SPECTACLE_INSTALLED=true
fi

if $IS_SPECTACLE_INSTALLED; then
  read -p "${ARROW} Configure Spectacle shotrcuts? [y/n]: "

  if [ "$REPLY" == "y" ]; then
    echo "${ARROW} Configuring Spectacle shotrcuts..."
    cp -r spectacle.json ~/Library/Application\ Support/Spectacle/Shortcuts.json 2> /dev/null
  fi
fi

#----------------------------
# Firmware password
#----------------------------

if [[ $(sudo firmwarepasswd -check) =~ "Password Enabled: Yes" ]]; then
  echo "${ARROW} Firmware password is already set up!"
else 
  read -p "${ARROW} Set up firmware password? [y/n]: "

  if [ "$REPLY" == "y" ]; then
    sudo firmwarepasswd -setpasswd -setmode command
  fi
fi

#----------------------------
# Computer name
#----------------------------

read -p "${ARROW} Set computer name? [y/n]: "

if [ "$REPLY" == "y" ]; then
  read -p 'Please enter computer name: ' uservar

  sudo scutil --set ComputerName $uservar
  sudo scutil --set HostName $uservar
  sudo scutil --set LocalHostName $uservar
fi

#----------------------------
# macOS Defaults
#----------------------------

read -p "${ARROW} Configure macOS Defaults? [y/n]: "

if [ "$REPLY" == "y" ]; then
  echo "${ARROW} Configuring macOS Defaults..."
  . ./api/defaults.sh
fi

echo -e "${NEW_LINE}${YELLOW}${BOLD}Note:$DEFAULT Some changes may need system restart to be applied!"
echo -e "${NEW_LINE}${GREEN}${BOLD}Congratulations, installation complete!${DEFUALT}"

exit 1
