clear

ARROW=$(tput bold)$(tput setaf 6; echo -n '==>'; tput sgr0;)

echo "Welcome to the installer!"
echo -e "First, introduce your password to execute all the commands as super user. \n"
echo -e "\033[1;31mImportant:\033[0m You can be asked more times for password during the process."
echo "Also, make sure that You are logged in to the Mac App Store."
echo

sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

install_bundle() {
  brew tap caskroom/cask

  brew install mas

  applications_to_install=(
    appcleaner
    cyberduck
    firefox
    flux
    fork
    google-chrome
    keepingyouawake
    keka
    mamp
    opera
    postman
    sequel-pro
    skype
    slack
    spectacle
    transmission
    tunnelblick
    visual-studio-code
    vlc
  )

  for application in "${applications_to_install[@]}"
  do
    brew cask install ${application}
  done

  mas install 408981434 #iMovie
  mas install 409203825 #Numbers
  mas install 409201541 #Pages
}

install_npm_packages() {
  npm_packages=(
    create-react-app
    gulp-cli
    jest
    live-server
    npm-upgrade
    webpack
  )

  for package in "${npm_packages[@]}"
  do
    npm install -g ${package}
  done
}

#----------------------------
# Homebrew
#----------------------------
IS_HOMEBREW_INSTALLED=false
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
IS_NVM_INSTALLED=false
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
IS_NODE_INSTALLED=false
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
# Npm packages
#----------------------------
if $IS_NODE_INSTALLED; then
  read -p "${ARROW} Install bundle of npm packages? [y/n]: "

  if [ "$REPLY" == "y" ]; then
    echo "${ARROW} Installing npm packages.."
    install_npm_packages
  fi
fi

#----------------------------
# VSCode extensions
#----------------------------
IS_VSCODE_INSTALLED=false
if hash code 2>/dev/null; then
  IS_VSCODE_INSTALLED=true
fi

if $IS_VSCODE_INSTALLED; then
  read -p "${ARROW} Install bundle of Visual Studio Code extensions? [y/n]: "

  if [ "$REPLY" == "y" ]; then
    echo "${ARROW} Installing Visual Studio Code extensions..."
    code --install-extension CoenraadS.bracket-pair-colorizer --install-extension PKief.material-icon-theme --install-extension alefragnani.project-manager --install-extension christian-kohler.path-intellisense --install-extension dbaeumer.vscode-eslint --install-extension formulahendry.auto-rename-tag --install-extension mrmlnc.vscode-scss --install-extension msjsdiag.debugger-for-chrome --install-extension techer.open-in-browser --install-extension wayou.vscode-todo-highlight --install-extension xabikos.ReactSnippets --install-extension kamikillerto.vscode-colorize
  fi
fi

#----------------------------
# VSCode Settings
#----------------------------
if $IS_VSCODE_INSTALLED; then
  read -p "${ARROW} Configure Visual Studio Code settings? [y/n]: "

  if [ "$REPLY" == "y" ]; then
    echo "${ARROW} Configuring Visual Studio Code..."
    cp settings.json /Users/${USER}/Library/Application\ Support/Code/User
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

echo -e "\033[1;33m\nNote:\033[0m Some changes may need system restart to be applied!\n\033[1;32m\nCongratulations, installation complete!\033[0m"

exit 1
