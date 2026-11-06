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
    COMMIT=70cbd7e455267402af156a5b733a774b15ef9949
    FILE_NAME="g/git-lfs.rb"
    FORMULA_NAME="git-lfs"
    brew_install_pinned_formula "$FORMULA_NAME" "$FILE_NAME" "$COMMIT"
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
