#!/bin/bash -e -o pipefail
################################################################################
##  File:  install-homebrew.sh
##  Desc:  Install Homebrew
################################################################################

source ~/utils/utils.sh

arch=$(get_arch)

echo "Installing Homebrew..."
if is_Arm64; then
    # For ARM64 architecture, download the latest Homebrew installer script
    homebrew_installer_path=$(download_with_retry "https://raw.githubusercontent.com/Homebrew/install/master/install.sh")
else
    # For Intel architecture, download the pinned Homebrew installer script
    # Homebrew dropped support for MacOS Intel since v 7.0.0
    # https://github.com/Homebrew/install/pull/1140
    homebrew_installer_path=$(download_with_retry "https://raw.githubusercontent.com/Homebrew/install/0f5b7666a65fc2d1a2615549f02771353c250f9a/install.sh")
fi
/bin/bash $homebrew_installer_path

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
if ! is_Arm64; then
    # For the Intel images curl dependency openssl@3 stopped to work, using pinned commit
    COMMIT=ac0bc95fef0e5aed25b3662f6271020410cfbc3d
    FILE_NAME="o/openssl@3.rb"
    FORMULA_NAME="openssl@3"
    brew_install_pinned_formula "$FORMULA_NAME" "$FILE_NAME" "$COMMIT"

    # Pinning curl to bypass dropping Intel support
    COMMIT_CURL=bce3d09048e3cb6e0a9e75a49f79ec33e321f328
    FILE_NAME_CURL="c/curl.rb"
    FORMULA_NAME_CURL="curl"
    brew_install_pinned_formula "$FORMULA_NAME_CURL" "$FILE_NAME_CURL" "$COMMIT_CURL"
else
    brew_smart_install curl
fi

echo "Installing wget..."
brew_smart_install "wget"
