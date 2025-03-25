#!/bin/bash

# MacOS Development Environment Setup Script
# For PHP/Laravel development
# With Fish shell, Kitty terminal, and Starship prompt
# -------------------------------------------

echo "Starting development environment setup..."

# Install Homebrew if not installed
if test ! $(which brew); then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  
  # Add Homebrew to path (for Apple Silicon Macs)
  if [[ $(uname -m) == 'arm64' ]]; then
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
fi

# Install our bundle
brew bundle install

# Install Laravel CLI
echo "Installing Laravel installer..."
composer global require laravel/installer

# Configure macOS settings
echo "Configuring macOS settings..."

# Show hidden files
defaults write com.apple.finder AppleShowAllFiles YES

# Show path bar in Finder
defaults write com.apple.finder ShowPathbar -bool true

# Show status bar in Finder
defaults write com.apple.finder ShowStatusBar -bool true

# Show Library folder
chflags nohidden ~/Library

# Restart Finder
killall Finder

# Autohide Dock
defaults write com.apple.dock autohide -bool true

# Minimize windows into application icon
defaults write com.apple.dock minimize-to-application -bool true

# Hide recent applications in Dock
defaults write com.apple.dock show-recents -bool false

# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# Restart Dock
killall Dock

# Start Fish
fish

# Install Fisher
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/HEAD/functions/fisher.fish | source && fisher install jorgebucaran/fisher

# Install nvm for Fish
fisher install jorgebucaran/nvm.fish