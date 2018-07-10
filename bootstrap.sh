#!/bin/bash

# Colors
BOLD=$(tput bold)
CYAN=$(tput setaf 6)
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
DEFAULT=$(tput sgr0)
# Arrow used when reading from input e.g. '==> Install Homebrew and update it? [y/n]: '
ARROW="$CYAN$BOLD==>$DEFAULT"
# For now, assume that none of necessary programs is installed
IS_HOMEBREW_INSTALLED=false
IS_NVM_INSTALLED=false
IS_NODE_INSTALLED=false
IS_VSCODE_INSTALLED=false
# Horizonal line in cyan color
DIVIDER="${CYAN}${BOLD}------------------------------------------------$DEFAULT"
# New line character
NEW_LINE="\n"
# Project logo
LOGO=" __  __               _____      _
|  \/  |             / ____|    | |
| \  / | __ _  ___  | (___   ___| |_ _   _ _ __
| |\/| |/ _\` |/ __|  \___ \ / _ \ __| | | | '_ \\
| |  | | (_| | (__   ____) |  __/ |_| |_| | |_) |
|_|  |_|\__,_|\___| |_____/ \___|\__|\__,_| .__/
                                          | |
                                          |_|"

# Clear the terminal screen
clear

# Print logo and description
echo -e "${CYAN}${BOLD}${LOGO}${DEFAULT}${NEW_LINE}"
echo -e "${CYAN}${BOLD}   Front End Web Development Setup for macOS$NEW_LINE"
echo -e "$DIVIDER"
echo "      <https://github.com/appalaszynski>"
echo "  <https://github.com/appalaszynski/mac-setup>"
echo -e "${DIVIDER}${NEW_LINE}"

PS3='
Number to execute: '

options=("Install" "Quit")
select opt in "${options[@]}"
do
  case $opt in
    "Install")
      . api/install.sh
      ;;
    "Quit")
      break
      ;;
    *) echo Invalid option!;;
  esac
done
