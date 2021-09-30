#!/bin/bash -e -o pipefail

source ~/utils/utils.sh

echo "Installing Homebrew..."
HOMEBREW_INSTALL_URL="https://raw.githubusercontent.com/Homebrew/install/master/install.sh"
/bin/bash -c "$(curl -fsSL ${HOMEBREW_INSTALL_URL})"

echo "Disabling Homebrew analytics..."
brew analytics off

# jq is required for further installation scripts
echo "Installing jq..."
brew install jq

echo "Installing curl..."
brew install curl

echo "Installing wget..."
brew_smart_install "wget"

# init brew bundle feature
brew tap Homebrew/bundle