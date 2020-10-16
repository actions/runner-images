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

echo "Install pip for Python 2"
# Set permissions to install pip modules in the main packages directory
sudo chmod -R 777 /Library/Python/2.7
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python get-pip.py