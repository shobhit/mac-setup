<div align="center">
  <a href="https://github.com/appalaszynski/mac-setup">
    <img src="https://user-images.githubusercontent.com/35331661/42627932-c9f65182-85ce-11e8-84b3-0133c88f8a7e.png" height="125px">
  </a>
  <h1>Mac Setup</h1>
  <p>
    <em>Front End Web Development Setup for macOS</em>
  </p>
  <p>
    <a href="https://github.com/appalaszynski/mac-setup/stargazers">
      <img src="https://img.shields.io/github/stars/appalaszynski/mac-setup.svg" alt="Stars" /> 
    </a>
    <a href="https://github.com/appalaszynski/mac-setup/commits/master">
      <img src="https://img.shields.io/github/last-commit/appalaszynski/mac-setup.svg" alt="Last Commit" />
    </a>
  </p>
  <br>
</div>

This document describes how I set up front end web development environment on my MacBook Air with **macOS Mojave 10.14.3**.

---

## Table of Contents

- [Installation](#installation)
- [System Preferences](#system-preferences)
- [Terminal](#terminal)
- [Bash](#bash)
- [Homebrew](#homebrew)
- [Git](#git)
- [Node.js](#nodejs)
- [Node Package Manager](#node-package-manager)
- [Web Browsers](#web-browsers)
- [Visual Studio Code](#visual-studio-code)

---

## Installation

You can follow the instructions below or use shell script to configure settings automatically. If you decided on the second option there are two ways:

- clone/download the repository into your computer and execute `install.sh` from the repository root directory:

```shell
$ cd mac-setup
$ ls
Brewfile               README.md              settings.json          spectacle.json
Flat.terminal          script                 snippets.code-snippets
$ bash script/install.sh
```

- one line installation - open your terminal and enter the following code:

```shell
$ curl -L https://github.com/appalaszynski/mac-setup/archive/master.tar.gz | tar -xvz; cd mac-setup-master; chmod +x script/install.sh; script/install.sh
```

<div align="center">
  <br>
  <img src="https://user-images.githubusercontent.com/35331661/46304817-fa0e7400-c5af-11e8-9e61-4677c1aff728.png">
</div>

---

## System Preferences

After a clean install of the operating system, there are a couple of tweaks I like to make to the System Preferences. Some of them are not strictly related to web development environment - I use them because of my personal habits.

- General > Appearance > Dark
- General > Ask to keep changes when closing documents
- General > Close windows when quitting an app
- Dock > Automatically hide and show the Dock
- Keyboard > Key Repeat > Fast (all the way to the right)
- Keyboard > Delay Until Repeat > Short (all the way to the right)

Much more settings can be configured via macOS `defaults` - command line utility that manipulates system configuration files. The system stores user preferences in a `.plist` files located in `~/Library/Preferences` directory.

### Set Dock Size

In my opinion, the best size of the dock is `35`. Remember that this is due to the size and resolution of my MacBook screen.

```shell
$ defaults write com.apple.dock tilesize -int 35; killall Dock
```

### Disable Press and Hold

Press and Hold function is used to create accents or diacritical marks. I don't need it, so I turn it off. You can always turn it back on by changing `false` to `true`.

```shell
$ defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
```

### Reset Icons in Launchpad

I usually use this command after installing every application that I need - it keeps Apple applications on the first page and moves the rest to the next pages.

```shell
$ defaults write com.apple.dock ResetLaunchPad -bool true; killall Dock
```

### Show Hidden Files

This can also be done by pressing `Command ⌘` + `Shift ⇧` + `.`.

```shell
$ defaults write com.apple.finder AppleShowAllFiles YES
```

### Show Path Bar in Finder

```shell
$ defaults write com.apple.finder ShowPathbar -bool true
```

### Show Status Bar in Finder

```shell
$ defaults write com.apple.finder ShowStatusBar -bool true
```

### Set Firmware Password

Setting a firmware password prevents your Mac from starting up from any device other than your startup disk. It may also be set to be required on each boot.

```shell
$ firmwarepasswd -setpasswd -setmode command
```

You can find a lot more settings in [defaults.sh](https://github.com/appalaszynski/mac-setup/blob/master/script/defaults.sh).

---

## Terminal

I use my custom Terminal profile which I called **Flat**. You can download it by typing:

```shell
$ curl -O https://raw.githubusercontent.com/appalaszynski/mac-setup/master/Flat.terminal
```

To use it as the default profile, open downloaded `Flat.terminal` file and click **Shell** > **Use settings as default** option.

---

## Bash

```shell
# Update Homebrew itself, upgrade all packages, remove dead symlinks, remove old versions
# of installed formulas, clean old downloads from cache, remove versions of formulas, which
# are downloaded, but not installed, check system for potential problems
alias brewup='brew update; brew upgrade; brew cask upgrade; brew cleanup; brew doctor'

# Easier navigation
alias ..="cd .."
alias ....="cd ../.."

# Shortcuts
alias p="cd ~/Projects"
alias d="cd ~/Desktop"

# Configure ls command
export CLICOLOR=1 # Enable ANSI colors sequences to distinguish file types
export LSCOLORS=GxFxCxDxBxegedabagaced # Value of this variable describes what color to use for which file type

# Color definitions (used in prompt)
RED='\[\033[1;31m\]'
GREEN='\[\033[1;32m\]'
YELLOW='\[\033[1;33m\]'
PURPLE='\[\033[1;35m\]'
GRAY='\[\033[1;30m\]'
DEFAULT='\[\033[0m\]'

# Function which prints current Git branch name (used in prompt)
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

# Configure prompt
PS1="${RED}\u" # Username
PS1+=" ${GRAY}• " # Separator
PS1+="${GREEN}\h" # Hostname
PS1+=" ${GRAY}• " # Separator
PS1+="${YELLOW}\w" # Working directory
PS1+=" ${GRAY}\$([[ -n \$(git branch 2> /dev/null) ]] && echo \"•\") " # Separator (if there is a Git repository)
PS1+="${PURPLE}\$(parse_git_branch)" # Git branch
PS1+="\n" # New line
PS1+="${GRAY}\$ " # Dollar sign
PS1+="${DEFAULT}" # Get back default color

export PS1;
```

When bash is invoked it looks for `~/.bash_profile`, reads it and executes commands from it.
In my `.bash_profile` file I create, among others, a `brewup` alias (keyboard shortcut to avoiding typing a long command sequence) to keep Homebrew (which we are going to install in a second) up to date. I also set the color scheme for `ls` command output and configure custom prompt, which contains username, computer name, working directory and current Git branch.

To download my `.bash_profile` and execute its content:

```shell
$ cd ~
$ curl -O https://raw.githubusercontent.com/appalaszynski/mac-setup/master/.bash_profile
$ source ~/.bash_profile
```

---

## Homebrew

[Homebrew](http://brew.sh/) package manager allows to install almost any application right from the command line:

```shell
$ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

Now, to install Homebrew package you can use use `brew install <package>`, for example:

```shell
$ brew install git
```

To install GUI macOS applications use [Homebrew Cask](https://github.com/Homebrew/homebrew-cask):

```shell
$ brew cask install <application name>
```

### Brewfile

Installing each application and package separately may take some time. [Homebrew Bundle](https://github.com/Homebrew/homebrew-bundle) allows to automatically install everything listed in the `Brewfile` file.

Here are all applications I usually install with a brief description.

- [Git](https://git-scm.com) - version control system
- [Ruby](https://www.ruby-lang.org) - programming language
- [mas-cli](https://github.com/mas-cli/mas) - Mac App Store command line interface
- [AppCleaner](https://freemacsoft.net/appcleaner) - apps uninstaller
- [Background Music](https://github.com/kyleneideck/BackgroundMusic) - audio utility
- [Cyberduck](https://cyberduck.io) - FTP client
- [draw.io](https://www.draw.io) - diagramming tool
- [Firefox](https://www.mozilla.org/firefox) - web browser
- [Flux](https://justgetflux.com) - screen color temperature adjusting app
- [Google Chrome](https://www.google.com/chrome/) - web browser
- [GPG Suite](https://gpgtools.org) - communication and files encryption tools
- [KeepingYouAwake](https://github.com/newmarcel/KeepingYouAwake) - app which prevents Mac from entering sleep mode
- [Keka](http://www.kekaosx.com) - file archiver
- [MAMP](https://www.mamp.info) - Apache, MySQL and PHP package
- [Opera](http://www.opera.com) - web browser
- [Postman](https://www.getpostman.com) - API testing tool
- [Sequel Pro](http://www.sequelpro.com) - MySQL GUI tool
- [Skype](https://www.skype.com) - voice and video chat
- [Slack](https://slack.com) - team collaboration tools
- [Sourcetree](https://www.sourcetreeapp.com/) - Git GUI client
- [Spectacle](https://www.spectacleapp.com) - window manager
- [Spotify](https://www.spotify.com) - digital music service
- [Transmission](https://transmissionbt.com) - BitTorrent client
- [Tunnelblick](https://tunnelblick.net) - GUI for OpenVPN
- [Visual Studio Code](https://code.visualstudio.com) - code editor
- [VLC](https://www.videolan.org/vlc) - media player
- [iMovie](https://www.apple.com/imovie) - video editor
- [Numbers](https://www.apple.com/numbers) - spreadsheet editor
- [Pages](https://www.apple.com/pages) - text editor
- [Xcode](https://developer.apple.com/xcode) - IDE for developing software for Apple products

Below are the entire contents of my `Brewfile`.

```ruby
# Install Git, Ruby and mas-cli via Homebrew
brew 'git'
brew 'ruby'
brew 'mas'

# Install applications via Homebrew Cask
cask 'appcleaner'
cask 'background-music'
cask 'cyberduck'
cask 'drawio'
cask 'firefox'
cask 'flux'
cask 'google-chrome'
cask 'gpg-suite'
cask 'keepingyouawake'
cask 'keka'
cask 'mamp'
cask 'opera'
cask 'postman'
cask 'sequel-pro'
cask 'skype'
cask 'slack'
cask 'sourcetree'
cask 'spectacle'
cask 'spotify'
cask 'transmission'
cask 'tunnelblick'
cask 'visual-studio-code'
cask 'vlc'

# Install applications from App Store via mas-cli
mas "iMovie", id: 408981434
mas "Numbers", id: 409203825
mas "Pages", id: 409201541
mas "Xcode", id: 497799835
```

To check App Store application ID you must install `mas-cli` first. Then, use `mac search <app name>`, for example:

```shell
$ mas search pages
```

My `Brewfile` file can be downloaded using:

```shell
$ curl -O https://raw.githubusercontent.com/appalaszynski/mac-setup/master/Brewfile
```

To install listed applications type:

```shell
$ brew bundle
```

in a directory that contains `Brewfile`.

---

## Git

You can set Git global configuration two ways. The first is to run a bunch of commands which will update the Git configuration file, e.g.

```shell
$ git config --global user.name "First Last"
$ git config --global user.email "email@email.com"
```

The other and faster way is creating the Git configuration file (`~/.gitconfig`) and input it all ourselves:

```shell
$ cd ~
$ curl -O https://raw.githubusercontent.com/appalaszynski/mac-setup/master/.gitconfig
$ open .gitconfig
```

```properties
[user]
  name = First Last
  email = email@email.com
[core]
  editor = editor
[credential]
  helper = osxkeychain
```

Here I set my name, email, core editor and connect Git to the macOS Keychain so I don’t have to type my username and password every time I want to push to GitHub.

### SSH

You can also authenticate with GiHub using SSH key:

```shell
$ ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
```

Above command will create a private key (`id_rsa`) and public key (`id_rsa.pub`) in `~/.ssh` directory.
Next, add your newly created SSH key to the ssh-agent to be able to manage your keys:

```shell
$ ssh-add <path to private key>
```

Now just login into your Github account and paste content of `id_rsa.pub` file in **Settings** > **SSH and GPG keys** > **New SSH key**.

After you've set up your SSH key and added it to your GitHub account, you can test your connection. Open terminal and enter the following code:

```shell
$ ssh -T git@github.com
```

After verifying fingerprint by typing `yes` you should see the following message:

```
Hi <your username>! You've successfully authenticated, but GitHub does not provide shell access.
```

---

## Node.js

For installation of the Node.js I like to use [Node Version Manager](https://github.com/creationix/nvm):

```shell
$ curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash
```

Now, you can list all available Node.js versions:

```shell
$ nvm list-remote
```

To install specific Node.js version:

```shell
$ nvm install <version>
```

---

## Node Package Manager

Packages which I use globally at the moment are:

- [gulp-cli](https://gulpjs.com)
- [jest](http://jestjs.io/)
- [live-server](http://tapiov.net/live-server/)
- [create-react-app](https://github.com/facebook/create-react-app)

To install npm packages globally use `npm install` with `-g` flag:

```shell
$ npm install -g gulp-cli jest live-server create-react-app
```

---

## Web Browsers

I have installed all major web browsers:

- [Chrome](https://www.google.com/chrome/)
- [Safari](https://www.apple.com/safari/)
- [Opera](https://www.opera.com/)
- [Firefox](https://www.mozilla.org/en-US/firefox/)

For development I use Chrome. To see how your site renders on Microsoft browsers like Edge or Internet Explorer you can use [Microsoft Developer Tools](https://developer.microsoft.com/en-us/microsoft-edge/tools/screenshots/) to generate screenshots for each of them.

### Chrome Extensions

- [uBlock Origin](https://chrome.google.com/webstore/detail/ublock-origin/cjpalhdlnbpafiamejdnhcphjbkeiagm) - block ads
- [Privacy Badger](https://chrome.google.com/webstore/detail/privacy-badger/pkehgijcmpdhfbdbbnkijodmdjhbjlgp) - block spying ads and invisible trackers
- [Nano Defender](https://chrome.google.com/webstore/detail/nano-defender/ggolfgbegefeeoocgjbmkembbncoadlb) - anti-adblock defuser
- [HTTPS Everywhere](https://chrome.google.com/webstore/detail/https-everywhere/gcbommkclmclpchllfjekcdonpmejbdp?hl=pl) - automatically switch from http to https
- [JSON Viewer](https://chrome.google.com/webstore/detail/json-viewer/gbmdgpbipfallnflgajpaliibnhdgobh) - validate and view JSON documents
- [React Developer Tools](https://chrome.google.com/webstore/detail/react-developer-tools/fmkadmapgofadopljbjfkapdkoienihi) - inspect component hierarchies and states
- [Redux DevTools](https://chrome.google.com/webstore/detail/redux-devtools/lmhkpmbekcpmknklioeibfkpmmfibljd) - inspect and debug state changes
- [Pesticide](https://chrome.google.com/webstore/detail/pesticide-for-chrome/bblbgcheenepgnnajgfpiicnbbdmmooh) - toggle different colored outlines on every element for quick CSS layout debug

---

## Visual Studio Code

All default settings changes are stored in `settings.json` file located in `/Users/<your username>/Library/Application Support/Code/User`. You can open it by pressing `Command ⌘` + `Shift ⇧` + `p` and choosing `Preferences: Open Settings (JSON)`.
Here are my `settings.json` contents:

```json
{
  "workbench.startupEditor": "newUntitledFile",
  "workbench.colorTheme": "Monokai",
  "workbench.activityBar.visible": false,
  "workbench.iconTheme": "material-icon-theme",
  "workbench.statusBar.feedback.visible": false,
  "workbench.list.openMode": "doubleClick",
  "workbench.tips.enabled": false,
  "workbench.enableExperiments": false,
  "workbench.editor.tabSizing": "shrink",
  "editor.fontSize": 12,
  "editor.tabSize": 2,
  "editor.multiCursorModifier": "ctrlCmd",
  "editor.wordWrap": "on",
  "editor.minimap.enabled": false,
  "editor.detectIndentation": false,
  "editor.dragAndDrop": false,
  "editor.renderLineHighlight": "all",
  "editor.formatOnSave": true,
  "problems.decorations.enabled": false,
  "telemetry.enableTelemetry": false,
  "telemetry.enableCrashReporter": false,
  "explorer.openEditors.visible": 0,
  "explorer.decorations.colors": false,
  "explorer.autoReveal": false,
  "breadcrumbs.enabled": true,
  "breadcrumbs.symbolPath": "off",
  "terminal.integrated.rendererType": "dom",
  "extensions.showRecommendationsOnlyOnDemand": true,
  "extensions.ignoreRecommendations": true,
  "files.insertFinalNewline": true,
  "files.exclude": {
    "**/node_modules/": true,
    "**/.localized": true
  },
  "html.autoClosingTags": false,
  "npm.enableScriptExplorer": true,
  "material-icon-theme.folders.theme": "classic",
  "material-icon-theme.hidesExplorerArrows": true,
  "material-icon-theme.folders.color": "#90a4ae",
  "material-icon-theme.opacity": 0.8,
  "bracketPairColorizer.activeScopeCSS": [
    "borderColor : {color}; opacity: 0.5",
    "backgroundColor : {color}"
  ],
  "eslint.autoFixOnSave": true,
  "bracketPairColorizer.highlightActiveScope": true,
  "prettier.eslintIntegration": true
}
```

You can copy and paste them or just download my `settings.json` file:

```shell
$ cd /Users/<your username>/Library/Application Support/Code/User
$ curl -O https://raw.githubusercontent.com/appalaszynski/mac-setup/master/settings.json
```

### Extensions

- [Bracket Pair Colorizer](https://marketplace.visualstudio.com/items?itemName=CoenraadS.bracket-pair-colorizer) - match brackets to be identified with colours
- [Debugger for Chrome](https://marketplace.visualstudio.com/items?itemName=msjsdiag.debugger-for-chrome) - debug JavaScript code running in Google Chrome from VS Code
- [ESLint](https://marketplace.visualstudio.com/items?itemName=dbaeumer.vscode-eslint) - integrate ESLint into VS Code
- [GitLens](https://marketplace.visualstudio.com/items?itemName=eamodio.gitlens) - supercharge the Git capabilities built into VS Code
- [Material Icon Theme](https://marketplace.visualstudio.com/items?itemName=PKief.material-icon-theme) - icons based on Material Design
- [open in browser](https://marketplace.visualstudio.com/items?itemName=techer.open-in-browser) - open any file in browser right from VS Code explorer
- [Prettier - Code formatter](https://marketplace.visualstudio.com/items?itemName=esbenp.prettier-vscode) - VS Code package to format files using Prettier.
- [vscode-styled-components](https://marketplace.visualstudio.com/items?itemName=jpoissonnier.vscode-styled-components) - syntax highlighting and IntelliSense for styled-components

To install all extensions by one command:

```shell
$ code --install-extension CoenraadS.bracket-pair-colorizer --install-extension msjsdiag.debugger-for-chrome --install-extension dbaeumer.vscode-eslint --install-extension eamodio.gitlens --install-extension esbenp.prettier-vscode --install-extension jpoissonnier.vscode-styled-components --install-extension PKief.material-icon-theme --install-extension techer.open-in-browser
```

### Snippets

I created my own global snippets instead of installing an extensions. User custom global snippets are located in `/Users/<your username>/Library/Application Support/Code/User/snippets` as files with `code-snippets` extension. You can easily create or edit them by going to **Code** > **Preferences** > **User Snippets**.

You can find all my snippets in [snippets.code-snippets](https://github.com/appalaszynski/mac-setup/blob/master/snippets.code-snippets).

### Keybindings

Custom Visual Studio Code keybindings are located in `/Users/<your username>/Library/Application Support/Code/User` as `keybindings.json` file. To manage them go to **Code** > **Preferences** > **Keyboard Shortcuts**.

My keybindingsa are listed in [keybindings.json](https://github.com/appalaszynski/mac-setup/blob/master/keybindings.json).
