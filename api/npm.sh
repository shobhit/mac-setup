#!/bin/bash

install_npm_packages() {
  # List of packages to install by npm
  npm_packages=(
    create-react-app
    gulp-cli
    jest
    live-server
    npm-upgrade
    webpack
  )

  # Install all listed packages
  for package in "${npm_packages[@]}"
  do
    npm install -g ${package}
  done
}
