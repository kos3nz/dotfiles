#!/usr/bin/env bash

# Finder
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowTabView -bool true
defaults write com.apple.finder NewWindowTarget -string PfHm

### Mouse & Trackpad
# Tap as click
defaults write -g com.apple.mouse.tapBehavior -int 1
# Increase mouse speed
defaults write -g com.apple.mouse.scaling 1
# Increase trackpad speed
defaults write -g com.apple.trackpad.scaling 1
defaults write -g com.apple.trackpad.scrolling 1

### Keyboard
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false # Disable full stop (dot) with double-space.
# Increase key reapet speed
defaults write -g InitialKeyRepeat -int 12 # normal minimum is 15 (225 ms)
defaults write -g KeyRepeat -int 1         # normal minimum is 2 (30 ms)

### Menubar
defaults write com.apple.menuextra.clock DateFormat -string "M\u6708d\u65e5(EEE)  H:mm:ss"

### Dock
# show hidden files in finder
defaults write com.apple.finder AppleShowAllFiles YES
# Automatically hide or show the Dock
defaults write com.apple.dock autohide -bool true
# Magnificate the Dock
defaults write com.apple.dock magnification -bool true

# Disable .DS_Store on network disks
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# After settings above, reboot these
killall Dock
killall Finder
killall SystemUIServer
