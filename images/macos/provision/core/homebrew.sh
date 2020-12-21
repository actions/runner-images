#!/bin/bash -e -o pipefail
source ~/utils/utils.sh

echo "Installing Homebrew..."
HOMEBREW_INSTALL_URL="https://raw.githubusercontent.com/Homebrew/install/master/install.sh"
/bin/bash -c "$(curl -fsSL ${HOMEBREW_INSTALL_URL})"

echo "Disabling Homebrew analytics..."
brew analytics off

if ! is_HighSierra; then
echo "Installing curl..."
brew install curl
fi

echo "Installing wget..."
brew install wget

echo "Installing jq..."
brew install jq

# init brew bundle feature
brew tap Homebrew/bundle