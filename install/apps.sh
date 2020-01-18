#!/bin/bash
#
# Install Homebrew and applications
# Check out https://brew.sh for more details
# Comment (with #) what should not be installed and add the applications you want to install.

source ./install/utils.sh

# Install Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew update
brew upgrade

# Install Homebrew formulas
brew install git
brew install nano
brew install node
brew install nvm
brew install python
brew install pipenv
brew install ruby
brew install unrar
brew install yarn
brew install zsh

# Install Homebrew taps
brew tap homebrew/cask-drivers
brew tap homebrew/cask-fonts
brew tap homebrew/cask-versions
brew tap homebrew/command-not-found

# Install Homebrew casks
brew cask install font-jetbrains-mono
brew cask install google-chrome
brew cask install iina
brew cask install iterm2
brew cask install qbittorrent
brew cask install visual-studio-code

# Install Homebrew Cask Upgrade
# Check out https://github.com/buo/homebrew-cask-upgrade for more details
brew tap buo/cask-upgrade
brew update
brew cu

# Finish
e_success "Finished applications installation."