#!/bin/bash -e -o pipefail

echo "Installing Homebrew..."
HOMEBREW_INSTALL_URL="https://raw.githubusercontent.com/Homebrew/install/master/install.sh"
/bin/bash -c "$(curl -fsSL ${HOMEBREW_INSTALL_URL})"

echo "Disabling Homebrew analytics..."
brew analytics off

# init brew bundle feature
brew tap Homebrew/bundle