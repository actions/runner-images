#!/bin/bash -e -o pipefail

source ~/utils/utils.sh

echo "Installing Python Tooling"

echo "Brew Installing Python 3"
# Workaround to have both 3.8 & 3.9(which required by some brew formulas) in the system, but only 3.8 is linked
brew install python@3.8
brew install python@3.9
brew unlink python@3.9
brew unlink python@3.8
brew link python@3.8

echo "Brew Installing Python 2"
# Create local tap with formula due to python2 formula depreciation
brew tap-new --no-git local/python2
FORMULA_PATH=$(brew extract python@2 local/python2 | grep "Homebrew/Library/Taps")
brew install $FORMULA_PATH
