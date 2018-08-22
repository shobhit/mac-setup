#!/bin/bash

install_bundle() {
  # Install Cask (Homebrew extension)
  brew tap caskroom/cask

  # Install mas-cli by Homebrew
  brew install mas

  # List of programs to install by Cask
  applications_to_install=(
    appcleaner
    background-music
    cyberduck
    drawio
    firefox
    flux
    fork
    google-chrome
    gpg-suite
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

  # Install all listed programs
  for application in "${applications_to_install[@]}"
  do
    brew cask install ${application}
  done

  # Install apps from App Store by mas-cli
  mas install 408981434 #iMovie
  mas install 409203825 #Numbers
  mas install 409201541 #Pages
  mas install 497799835 #Xcode
}
