#!/bin/bash -e -o pipefail

source ~/utils/utils.sh

echo "Installing Python Tooling"

echo "Brew Installing Python 3"
brew install python@3.9

echo "Install pip for Python 2"
# Set permissions to install pip modules in the main packages directory
sudo chmod -R 777 /Library/Python/2.7
sudo chmod -R 777 /System/Library/Frameworks/Python.framework/Versions/2.7
# Create symlink for backwards compatibility
ln -s /usr/bin/python /usr/local/bin/python
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
# Workaround for High Sierra pip, since it installs into /usr/bin. On the modern macOSs pip installation directory is /usr/local/bin
if ! is_HighSierra; then
    python get-pip.py
else
    sudo chmod 777 /usr/bin
    python get-pip.py
    ln -s /usr/bin/pip /usr/local/bin/pip
    sudo chmod 755 /usr/bin
fi

echo "Installing pipx"
export PIPX_BIN_DIR=/usr/local/opt/pipx_bin
export PIPX_HOME=/usr/local/opt/pipx

brew install pipx

echo "export PIPX_BIN_DIR=${PIPX_BIN_DIR}" >> "${HOME}/.bashrc"
echo "export PIPX_HOME=${PIPX_HOME}" >> "${HOME}/.bashrc"
echo 'export PATH="$PIPX_BIN_DIR:$PATH"' >> "${HOME}/.bashrc"