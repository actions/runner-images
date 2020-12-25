#!/bin/bash -e -o pipefail

source ~/utils/utils.sh

echo "Installing Homebrew..."
HOMEbrew_smart_install_URL="https://raw.githubusercontent.com/Homebrew/install/master/install.sh"
/bin/bash -c "$(curl -fsSL ${HOMEbrew_smart_install_URL})"

echo "Disabling Homebrew analytics..."
brew analytics off

# jq is required for further installation scripts
echo "Installing jq..."
brew install jq

echo "Installing curl..."
brew_smart_install "curl"

echo "Installing wget..."
brew_smart_install "wget"

# init brew bundle feature
brew tap Homebrew/bundle