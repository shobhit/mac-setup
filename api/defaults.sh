#################################
#### FINDER
#################################

# Show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Show path bar
defaults write com.apple.finder ShowPathbar -bool true

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# Set 'home directory' as default, new window directory
defaults write com.apple.finder NewWindowTarget -string "PfHm"

# Disable showing tags
defaults write com.apple.finder ShowRecentTags -int 0

#################################
#### SAFARI
#################################

# Disable auto-fill
defaults write com.apple.Safari AutoFillCreditCardData -int 0
defaults write com.apple.Safari AutoFillFromAddressBook -int 0
defaults write com.apple.Safari AutoFillMiscellaneousForms -int 0
defaults write com.apple.Safari AutoFillPasswords -int 0

# Prevent Safari from opening ‘safe’ files automatically after downloading
defaults write com.apple.Safari AutoOpenSafeDownloads -int 0

# Remove history after one day
defaults write com.apple.Safari HistoryAgeInDaysLimit -int 1

# Prevent Safari from loading "best match" site before opening it
defaults write com.apple.Safari PreloadTopHit -int 0

# Enable “Do Not Track”
defaults write com.apple.Safari SendDoNotTrackHTTPHeader -int 1

# Show the full URL in the address bar
defaults write com.apple.Safari ShowFullURLInSmartSearchField -int 1

# Don’t send search queries to Apple
defaults write com.apple.Safari SuppressSearchSuggestions -int 0
defaults write com.apple.Safari UniversalSearchEnabled -int 0
defaults write com.apple.Safari WebsiteSpecificSearchEnabled -int 0

# Enable the Develop menu and the Web Inspector in Safari
defaults write com.apple.Safari IncludeDevelopMenu -int 1
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -int 1

########################################
#### DOCK
########################################

# Set Dock size
defaults write com.apple.dock tilesize -int 35

# Auto-hide Dock
defaults write com.apple.dock autohide -int 1

# Disable animations
defaults write com.apple.dock launchanim -int 0

# Disable minimizing windows into their application’s icon
defaults write com.apple.dock minimize-to-application -int 0

# Show indicator lights for open applications in the Dock
defaults write com.apple.dock show-process-indicators -int 1

# Change minimize/maximize window effect
defaults write com.apple.dock mineffect -string "scale"

# Disable double-click on window's title bar to minimize it
defaults write NSGlobalDomain AppleActionOnDoubleClick None

#################################
#### TRACKPAD
#################################

# Enable tap to click
defaults write com.apple.AppleMultitouchTrackpad Clicking -int 1
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -int 1

# Enable right click (tap with two fingers)
defaults write com.apple.AppleMultitouchTrackpad TrackpadRightClick -int 1
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -int 1

# Enable application change (swipe horizontal witch three fingers)
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerHorizSwipeGesture -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerHorizSwipeGesture -int 2

# Enable the Launchpad gesture (pinch with thumb and three fingers)
defaults write com.apple.dock showLaunchpadGestureEnabled -int 1

# Enable Expose gesture (slide down with three fingers)
defaults write com.apple.dock showAppExposeGestureEnabled -int 1

#################################
#### KEYBOARD
#################################

# Disable press-and-hold for keys in favor of key repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Disable smart dashes
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Disable automatic period substitution
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

# Disable smart quotes
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
defaults write NSGlobalDomain WebAutomaticSpellingCorrectionEnabled -int 0

# Disable automatic capitalization
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# Set keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Enable full keyboard access for all controls
# (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

#################################
#### OTHER
#################################

# Disable transparency
defaults write com.apple.universalaccess reduceTransparency -bool true

# Use plain text mode for new TextEdit documents
defaults write com.apple.TextEdit RichText -int 0

# Disable spelling check in TextEdit documents
defaults write com.apple.TextEdit CheckSpellingWhileTyping -int 0

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Enable Dark Mode
defaults write NSGlobalDomain AppleInterfaceStyle Dark

# Reset icons order in Dashboard
defaults write com.apple.dock ResetLaunchPad -bool true

# Show battery percentage in Menu Bar
defaults write com.apple.menuextra.battery ShowPercent YES

# Close windows then quitting an app
defaults write NSGlobalDomain NSQuitAlwaysKeepsWindows -int 0

# Ask to kepp change when closing documents
defaults write NSGlobalDomain NSCloseAlwaysConfirmsChanges -int 1

# Set alert sound
defaults write NSGlobalDomain com.apple.sound.beep.sound -string "/System/Library/Sounds/Funk.aiff"

# Set date format in menubar
defaults write "com.apple.menuextra.clock" DateFormat -string "EEE d.MM  HH:mm"
defaults write "com.apple.systemuiserver" DateFormat -string "EEE d.MM  HH:mm"

# Enable snap-to-grid for icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

# Decrease grid spacing for icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:gridSpacing 15" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:gridSpacing 15" ~/Library/Preferences/com.apple.finder.plist

# Decrease the size of icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:iconSize 44" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:iconSize 44" ~/Library/Preferences/com.apple.finder.plist

# Disable icons preview on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:showIconPreview 0" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:showIconPreview 0" ~/Library/Preferences/com.apple.finder.plist

applications_to_kill=(
  "Activity Monitor"
  "Dock"
  "Finder"
)

killall "${applications_to_kill[@]}"
