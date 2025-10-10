#!/bin/bash -e -o pipefail
################################################################################
##  File:  install-python.sh
##  Desc:  Install Python
################################################################################

source ~/utils/utils.sh

echo "Installing Python Tooling"

# Close Finder window
close_finder_window

# Installing latest Homebrew Python 3 to handle python3 and pip3 symlinks
# When latest Python3 is installed as a dependency for other packages
# it does not create /usr/local/bin/python3 and /usr/local/bin/pip3
echo "Brew Installing default Python 3"
brew_smart_install "python"

# Install specific Python version
# Update symlinks for python3 and pip3 to point to the specific version
toolsetVersion=$(get_toolset_value '.python.default')
echo "Installing Python $toolsetVersion"
brew_smart_install "python@$toolsetVersion"

# Pipx has its own Python dependency
echo "Installing pipx"

if is_Arm64; then
    export PIPX_BIN_DIR="$HOME/.local/bin"
    export PIPX_HOME="$HOME/.local/pipx"
else
    export PIPX_BIN_DIR=/usr/local/opt/pipx_bin
    export PIPX_HOME=/usr/local/opt/pipx
fi

brew_smart_install "pipx"

echo "export PIPX_BIN_DIR=${PIPX_BIN_DIR}" >> ${HOME}/.bashrc
echo "export PIPX_HOME=${PIPX_HOME}" >> ${HOME}/.bashrc
echo 'export PATH="$PIPX_BIN_DIR:$PATH"' >> ${HOME}/.bashrc

invoke_tests "Python"
