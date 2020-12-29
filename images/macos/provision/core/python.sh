#!/bin/bash -e -o pipefail

source ~/utils/utils.sh

echo "Installing Python Tooling"

echo "Install latest Python 2"
Python2Url="https://www.python.org/ftp/python/2.7.18/python-2.7.18-macosx10.9.pkg"
download_with_retries $Python2Url "/tmp" "python2.pkg"
sudo installer -pkg /tmp/python2.pkg -target /
pip install --upgrade pip

echo "Install Python2 certificates"
bash -c "/Applications/Python\ 2.7/Install\ Certificates.command"

# Explicitly overwrite symlinks created by Python2 such as /usr/local/bin/2to3 since they conflict with symlinks from Python3
# https://github.com/actions/virtual-environments/issues/2322
echo "Brew Installing Python 3"
brew_smart_install "python@3.9" || brew link --overwrite python@3.9

echo "Installing pipx"
export PIPX_BIN_DIR=/usr/local/opt/pipx_bin
export PIPX_HOME=/usr/local/opt/pipx

brew_smart_install "pipx"

echo "export PIPX_BIN_DIR=${PIPX_BIN_DIR}" >> "${HOME}/.bashrc"
echo "export PIPX_HOME=${PIPX_HOME}" >> "${HOME}/.bashrc"
echo 'export PATH="$PIPX_BIN_DIR:$PATH"' >> "${HOME}/.bashrc"