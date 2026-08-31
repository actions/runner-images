#!/bin/bash -e -o pipefail
################################################################################
##  File:  install-git.sh
##  Desc:  Install Git and Git LFS
################################################################################

source ~/utils/utils.sh

echo "Installing Git..."
brew_smart_install "git"

git config --global --add safe.directory "*"

echo "Installing Git LFS"
if is_Arm64; then
    # git-lfs works fine on ARM64 images
    brew_smart_install "git-lfs"
else
    # For the Intel images git-lfs stopped to work, using pinned commit
    echo "Installing pinned git-lfs formulae..."
    COMMIT=70cbd7e455267402af156a5b733a774b15ef9949
    FORMULA_URL="https://raw.githubusercontent.com/Homebrew/homebrew-core/$COMMIT/Formula/g/git-lfs.rb"
    FORMULA_PATH="$(brew --repository)/Library/Taps/homebrew/homebrew-core/Formula/g/git-lfs.rb"
    mkdir -p "$(dirname $FORMULA_PATH)"
    curl -fsSL $FORMULA_URL -o $FORMULA_PATH
    HOMEBREW_NO_AUTO_UPDATE=1 HOMEBREW_NO_INSTALL_FROM_API=1 brew install git-lfs
fi

# Update global git config
git lfs install
# Update system git config
sudo git lfs install --system

echo "Disable all the Git help messages..."
git config --global advice.pushUpdateRejected false
git config --global advice.pushNonFFCurrent false
git config --global advice.pushNonFFMatching false
git config --global advice.pushAlreadyExists false
git config --global advice.pushFetchFirst false
git config --global advice.pushNeedsForce false
git config --global advice.statusHints false
git config --global advice.statusUoption false
git config --global advice.commitBeforeMerge false
git config --global advice.resolveConflict false
git config --global advice.implicitIdentity false
git config --global advice.detachedHead false
git config --global advice.amWorkDir false
git config --global advice.rmHints false

invoke_tests "Git"
