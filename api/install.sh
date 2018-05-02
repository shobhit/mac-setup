clear #Clear terminal screen

ARROW=$(tput setaf 6; echo -n '=>'; tput sgr0;)

echo "Welcome to the installer!"
echo -e "First, introduce your password to execute all the commands as super user. \n"
echo -e "\033[0;31mNote:\033[0m You can be asked more times for password during the process. Also, during"
echo "instalation of some applications You may be required to log in to Mac App Store."
echo

sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

install_homebrew() {
    if hash brew 2>/dev/null; then
        echo "Homebrew already installed!"
    else
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi
}

update_homebrew() {
  brew update # Make sure we’re using the latest Homebrew.
  brew upgrade
}

install_git() {
  brew install git
}

install_bundle() {
  brew tap caskroom/cask

  brew install mas

  applications_to_install=(
    appcleaner
    filezilla
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
    visual-studio-code
    vlc
  )

  brew cask install "${applications_to_install[@]}"

  mas install 408981434 #iMovie
  mas install 409203825 #Numbers
  mas install 409201541 #Pages
}

install_npm_packages() {
  npm_packages=(
    gulp-cli
    webpack
    npm-upgrade
  )

  npm install -g "${npm_packages[@]}"
}

read -ep "${ARROW} Install Homebrew and update it? [y/n]: "

if [ "$REPLY" == "y" ]; then
  echo "${ARROW} Installing Homebrew..."
  install_homebrew

  echo "${ARROW} Updating Homebrew formulas..."
  update_homebrew
fi

read -p "${ARROW} Install latest Git version? [y/n]: "

if [ "$REPLY" == "y" ]; then
  echo "${ARROW} Installing Git..."
  install_git
fi

read -p "${ARROW} Configure .bash_profile? [y/n]: "

if [ "$REPLY" == "y" ]; then
  echo "${ARROW} Configuring .bash_profile..."
  cp .bash_profile ~ 
fi

read -p "${ARROW} Install bundle of applications? [y/n]: "

if [ "$REPLY" == "y" ]; then
  echo "${ARROW} Installing applications..."
  install_bundle
fi

read -p "${ARROW} Install nvm (Node Version Manager)? [y/n]: "

if [ "$REPLY" == "y" ]; then
  echo "${ARROW} Installing Node Version Manager..."
  curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
  source ~/.bash_profile
fi

read -p "${ARROW} Install Node.js v9.10.0? [y/n]: "

if [ "$REPLY" == "y" ]; then
  echo "${ARROW} Installing Node.js v9.10.0..."
  nvm install 9.10.0
fi

read -p "${ARROW} Install bundle of npm packages? [y/n]: "

if [ "$REPLY" == "y" ]; then
  echo "${ARROW} Installing npm packages.."
  install_npm_packages
fi

read -p "${ARROW} Install bundle of Visual Studio Code extensions? [y/n]: "

if [ "$REPLY" == "y" ]; then
  echo "${ARROW} Installing Visual Studio Code extensions..."
  code --install-extension CoenraadS.bracket-pair-colorizer --install-extension PKief.material-icon-theme --install-extension alefragnani.project-manager --install-extension christian-kohler.path-intellisense --install-extension dbaeumer.vscode-eslint --install-extension formulahendry.auto-rename-tag --install-extension mrmlnc.vscode-scss --install-extension msjsdiag.debugger-for-chrome --install-extension techer.open-in-browser --install-extension wayou.vscode-todo-highlight --install-extension xabikos.ReactSnippets
fi

read -p "${ARROW} Configure Visual Studio Code settings? [y/n]: "

if [ "$REPLY" == "y" ]; then
  echo "${ARROW} Configuring Visual Studio Code..."
  cp settings.json /Users/${USER}/Library/Application\ Support/Code/User
fi

read -p "${ARROW} Configure .gitconfig? [y/n]: "

if [ "$REPLY" == "y" ]; then
  echo "${ARROW} Configuring .gitconfig..."
  cp .gitconfig ~
fi

read -p "${ARROW} Configure Spectacle app? [y/n]: "

if [ "$REPLY" == "y" ]; then
  echo "${ARROW} Configuring Spectacle..."
  cp -r spectacle.json ~/Library/Application\ Support/Spectacle/Shortcuts.json 2> /dev/null
fi

read -p "${ARROW} Configure macOS Defaults? [y/n]: "

if [ "$REPLY" == "y" ]; then
  echo "${ARROW} Configuring macOS Defaults..."
  . ./api/defaults.sh
fi

echo -e "\033[0;32m\nCongratulations, installation complete!\033[0m"

exit 1
