#!/bin/bash -e
################################################################################
##  File:  python.sh
##  Desc:  Installs Python 2/3
################################################################################

set -e
# Source the helpers for use with the script
source $HELPER_SCRIPTS/etc-environment.sh
source $HELPER_SCRIPTS/os.sh

# Install Python, Python 3, pip, pip3
if isUbuntu18; then
    apt-get install -y --no-install-recommends python python-dev python-pip
fi

apt-get install -y --no-install-recommends python3 python3-dev python3-pip python3-venv

# Install pipx
# Set pipx custom directory
export PIPX_BIN_DIR=/opt/pipx_bin
export PIPX_HOME=/opt/pipx
python3 -m pip install pipx
python3 -m pipx ensurepath
# Update /etc/environment
setEtcEnvironmentVariable "PIPX_BIN_DIR" $PIPX_BIN_DIR
setEtcEnvironmentVariable "PIPX_HOME" $PIPX_HOME
prependEtcEnvironmentPath $PIPX_BIN_DIR
# Test pipx
if ! command -v pipx; then
    echo "pipx was not installed or not found on PATH"
    exit 1
fi

# Adding this dir to PATH will make installed pip commands are immediately available.
prependEtcEnvironmentPath '$HOME/.local/bin'

invoke_tests "Tools" "Python"
