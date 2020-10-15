#!/bin/sh
source ~/utils/utils.sh

echo "Installing Python Tooling"

echo "Brew Installing Python 3"
# Workaround to have both 3.8 & 3.9(which required by some brew formulas) in the system, but only 3.8 is linked
/usr/local/bin/brew install python@3.8
/usr/local/bin/brew install python@3.9
/usr/local/bin/brew unlink python@3.9
/usr/local/bin/brew unlink python@3.8
/usr/local/bin/brew link python@3.8

echo "Brew Installing Python 2"
# Create local tap with formula due to python2 formula depreciation
/usr/local/bin/brew tap-new local/python2
FORMULA_PATH=$(/usr/local/bin/brew extract python@2 local/python2 | grep "Homebrew/Library/Taps")
/usr/local/bin/brew install $FORMULA_PATH
