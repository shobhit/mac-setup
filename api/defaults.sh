#################################
#### FINDER
#################################

# Show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Show path bar
defaults write com.apple.finder ShowPathbar -bool true

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Always open everything in Finder's columns view.
# Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`, 'Nlsv'
defaults write com.apple.finder FXPreferredViewStyle -string "clmv"

# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

########################################
#### DOCK, DASHBOARD, GESTURES
########################################

# Set Dock size
defaults write com.apple.dock tilesize -int 35; killall Dock

# Reset icons order in Dashboard
defaults write com.apple.dock ResetLaunchPad -bool true; killall Dock

# Auto-hide Dock
defaults write "com.apple.dock" autohide -int 1

# Disable animations
defaults write "com.apple.dock" launchanim -int 0

# Enable Expose gesture (slide down with three fingers)
defaults write "com.apple.dock" showAppExposeGestureEnabled -int 1

# Disable minimizing windows into their application’s icon
defaults write "com.apple.dock" "minimize-to-application" -int 0

# Show indicator lights for open applications in the Dock
defaults write "com.apple.dock" "show-process-indicators" -int 1

# Enable the Launchpad gesture (pinch with thumb and three fingers)
defaults write "com.apple.dock" "showLaunchpadGestureEnabled" -int 1

# Change minimize/maximize window effect
defaults write com.apple.dock mineffect -string "scale"

#################################
#### TRACKPAD
#################################

# Enable tap to click for this user and for the login screen
defaults write "com.apple.AppleMultitouchTrackpad" Clicking -int 1
defaults write "com.apple.driver.AppleBluetoothMultitouch.trackpad" Clicking -int 1

# Enable right click (tap with two fingers)
defaults write "com.apple.AppleMultitouchTrackpad" TrackpadRightClick -int 1
defaults write "com.apple.driver.AppleBluetoothMultitouch.trackpad" TrackpadRightClick -int 1

# Enable application change (swipe horizontal witch three fingers)
defaults write "com.apple.AppleMultitouchTrackpad" TrackpadThreeFingerHorizSwipeGesture -int 2
defaults write "com.apple.driver.AppleBluetoothMultitouch.trackpad" TrackpadThreeFingerHorizSwipeGesture -int 2

#################################
#### NSGlobalDomain
#################################

# Disable press-and-hold for keys in favor of key repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Disable automatic capitalization
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# Disable smart dashes
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Disable automatic period substitution
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

# Disable smart quotes
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Enable Dark Mode
defaults write NSGlobalDomain AppleInterfaceStyle Dark

# Enable full keyboard access for all controls
# (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Set keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Enable tap to click for the login screeni
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

defaults write NSGlobalDomain AppleActionOnDoubleClick None
defaults write NSGlobalDomain NSQuitAlwaysKeepsWindows -int 0
defaults write NSGlobalDomain NSCloseAlwaysConfirmsChanges -int 1
defaults write NSGlobalDomain WebAutomaticSpellingCorrectionEnabled -int 0
defaults write NSGlobalDomain com.apple.sound.beep.sound -string "/System/Library/Sounds/Funk.aiff"
defaults write NSGlobalDomain userMenuExtraStyle -int 2

#################################
#### Other
#################################

# Show battery percentage in Menu Bar
defaults write com.apple.menuextra.battery -bool true

# Use 'Flat' terminal profile
defaults write com.apple.Terminal "Default Window Settings" Flat
defaults write com.apple.Terminal "Startup Window Settings" Flat

# Disable the sound effects on boot
sudo nvram SystemAudioVolume=" "

# Configure Flux
defaults write org.herf.Flux location "52.223033,18.251073"
defaults write org.herf.Flux locationTextField "Konin"

# Ddisable some Spotlight search results
defaults write com.apple.spotlight orderedItems -array \
  '{"enabled" = 1;"name" = "APPLICATIONS";}' \
  '{"enabled" = 0;"name" = "MENU_SPOTLIGHT_SUGGESTIONS";}' \
  '{"enabled" = 0;"name" = "MENU_CONVERSION";}' \
  '{"enabled" = 0;"name" = "MENU_EXPRESSION";}' \
  '{"enabled" = 0;"name" = "MENU_DEFINITION";}' \
  '{"enabled" = 0;"name" = "SYSTEM_PREFS";}' \
  '{"enabled" = 0;"name" = "DOCUMENTS";}' \
  '{"enabled" = 0;"name" = "DIRECTORIES";}' \
  '{"enabled" = 0;"name" = "PRESENTATIONS";}' \
  '{"enabled" = 0;"name" = "SPREADSHEETS";}' \
  '{"enabled" = 0;"name" = "PDF";}' \
  '{"enabled" = 0;"name" = "MESSAGES";}' \
  '{"enabled" = 0;"name" = "CONTACT";}' \
  '{"enabled" = 0;"name" = "EVENT_TODO";}' \
  '{"enabled" = 0;"name" = "IMAGES";}' \
  '{"enabled" = 0;"name" = "BOOKMARKS";}' \
  '{"enabled" = 0;"name" = "MUSIC";}' \
  '{"enabled" = 0;"name" = "MOVIES";}' \
  '{"enabled" = 0;"name" = "FONTS";}' \
  '{"enabled" = 0;"name" = "MENU_OTHER";}'


# Enable snap-to-grid for icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

# Decrease grid spacing for icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:gridSpacing 20" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:gridSpacing 20" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:gridSpacing 20" ~/Library/Preferences/com.apple.finder.plist

# Decrease the size of icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:iconSize 44" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:iconSize 44" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:iconSize 44" ~/Library/Preferences/com.apple.finder.plist

# Disable icons preview on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:showIconPreview 0" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:showIconPreview 0" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:showIconPreview 0" ~/Library/Preferences/com.apple.finder.plist

# Disable transparency in the menu bar and elsewhere on Yosemite
defaults write com.apple.universalaccess reduceTransparency -bool true

# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Use plain text mode for new TextEdit documents
defaults write com.apple.TextEdit RichText -int 0

# Disable spelling check in TextEdit documents
defaults write com.apple.TextEdit CheckSpellingWhileTyping -int 0

# Set up date format in menubar
defaults write "com.apple.menuextra.clock" DateFormat -string "EEE d.MM  HH:mm"
defaults write "com.apple.systemuiserver" DateFormat -string "EEE d.MM  HH:mm"

## Order of menu bar icons
defaults write "com.apple.systemuiserver" "NSStatusItem Preferred Position com.apple.menuextra.bluetooth" -int 489
defaults write "com.apple.systemuiserver" "NSStatusItem Preferred Position com.apple.menuextra.airport" -int 435
defaults write "org.herf.Flux" "NSStatusItem Preferred Position Item-0" -float 408.5
defaults write "com.divisiblebyzero.Spectacle" "NSStatusItem Preferred Position Item-0" -int 383
defaults write "info.marcel-dierkes.KeepingYouAwake" "NSStatusItem Preferred Position Item-0" -int 354
defaults write "com.apple.systemuiserver" "NSStatusItem Preferred Position com.apple.menuextra.volume" -int 324
defaults write "com.apple.systemuiserver" "NSStatusItem Preferred Position com.apple.menuextra.battery" -int 273 
defaults write "com.apple.systemuiserver" "NSStatusItem Preferred Position com.apple.menuextra.clock" -int 179
defaults write "com.apple.systemuiserver" "NSStatusItem Preferred Position com.apple.menuextra.appleuser" -string "101.5"
defaults write "com.apple.systemuiserver" "NSStatusItem Visible Siri" -int 0
defaults write "com.apple.systemuiserver" "NSStatusItem Visible com.apple.menuextra.airport" -int 1
defaults write "com.apple.systemuiserver" "NSStatusItem Visible com.apple.menuextra.appleuser" -int 1
defaults write "com.apple.systemuiserver" "NSStatusItem Visible com.apple.menuextra.battery" -int 1
defaults write "com.apple.systemuiserver" "NSStatusItem Visible com.apple.menuextra.bluetooth" -int 1
defaults write "com.apple.systemuiserver" "NSStatusItem Visible com.apple.menuextra.clock" -int 1
defaults write "com.apple.systemuiserver" "NSStatusItem Visible com.apple.menuextra.volume" -int 1
defaults write "com.apple.systemuiserver" menuExtras -array "/System/Library/CoreServices/Menu Extras/Clock.menu" "/System/Library/CoreServices/Menu Extras/AirPort.menu" "/System/Library/CoreServices/Menu Extras/User.menu" "/System/Library/CoreServices/Menu Extras/Battery.menu" "/System/Library/CoreServices/Menu Extras/Volume.menu" "/System/Library/CoreServices/Menu Extras/Bluetooth.menu"

applications_to_kill=(
  "Activity Monitor"
  "Dock"
  "Finder"
)

killall "${applications_to_kill[@]}"
