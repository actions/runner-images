#!/bin/bash -e -o pipefail

source ~/utils/utils.sh

arch=$(get_arch)

echo "Installing Homebrew..."
download_with_retries "https://raw.githubusercontent.com/Homebrew/install/master/install.sh" "/tmp" "homebrew-install.sh"
/bin/bash /tmp/homebrew-install.sh

if [[ $arch == "arm64" ]]; then
  /opt/homebrew/bin/brew update
  /opt/homebrew/bin/brew upgrade
  /opt/homebrew/bin/brew upgrade --cask
  /opt/homebrew/bin/brew cleanup
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

git clone https://github.com/Homebrew/homebrew-cask $(brew --repository)/Library/Taps/homebrew/homebrew-cask --origin=origin --template= --config core.fsmonitor=false --depth 1
git clone https://github.com/Homebrew/homebrew-core $(brew --repository)/Library/Taps/homebrew/homebrew-core --origin=origin --template= --config core.fsmonitor=false --depth 1

brew tap homebrew/cask
brew tap homebrew/core

echo "Disabling Homebrew analytics..."
brew analytics off

# jq is required for further installation scripts
echo "Installing jq..."
brew_smart_install jq

echo "Installing curl..."
brew_smart_install curl

echo "Installing wget..."
brew_smart_install "wget"

# init brew bundle feature
brew tap Homebrew/bundle