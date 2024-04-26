#!/bin/bash -e
################################################################################
##  File:  install-python.sh
##  Desc:  Install Python 3
################################################################################

set -e
# Source the helpers for use with the script
source $HELPER_SCRIPTS/etc-environment.sh
source $HELPER_SCRIPTS/os.sh

# Install Python, Python 3, pip, pip3
apt-get install -y --no-install-recommends python3 python3-dev python3-pip python3-venv

# Install pipx
# Set pipx custom directory
export PIPX_BIN_DIR=/opt/pipx_bin
export PIPX_HOME=/opt/pipx
if is_ubuntu24; then
    apt-get install -y --no-install-recommends pipx
    pipx ensurepath
else
    python3 -m pip install pipx
    python3 -m pipx ensurepath
fi
# Update /etc/environment
set_etc_environment_variable "PIPX_BIN_DIR" $PIPX_BIN_DIR
set_etc_environment_variable "PIPX_HOME" $PIPX_HOME
prepend_etc_environment_path $PIPX_BIN_DIR

# Test pipx
if ! command -v pipx; then
    echo "pipx was not installed or not found on PATH"
    exit 1
fi

# Adding this dir to PATH will make installed pip commands are immediately available.
prepend_etc_environment_path '$HOME/.local/bin'

invoke_tests "Tools" "Python"
