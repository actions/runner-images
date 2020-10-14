#!/bin/bash -e -o pipefail

source ~/utils/utils.sh

echo "Installing Command Line Tools..."
install_clt

# Retry the installation if tools are not installed from the first attempt
retries=30
sleepInterval=60
while ! is_clt_installed; do
    if [[ $retries -eq 0 ]]; then
        echo "Unable to find the Command Line Tools, all the attempts exhausted"
        exit 1
    fi
    echo "Command Line Tools not found, trying to install them via softwareupdates, $retries attempts left"
    install_clt
    ((retries--))
    echo "Wait $sleepInterval seconds before the next check for installed Command Line Tools"
    sleep $sleepInterval
done

echo "Installing Homebrew..."
HOMEBREW_INSTALL_URL="https://raw.githubusercontent.com/Homebrew/install/master/install.sh"
/bin/bash -c "$(curl -fsSL ${HOMEBREW_INSTALL_URL})"

echo "Disabling Homebrew analytics..."
brew analytics off

echo "Installing the latest curl..."
brew install curl

echo "Installing wget..."
brew install wget

echo "Installing jq..."
brew install jq

# init brew bundle feature
brew tap Homebrew/bundle