#!/bin/bash
################################################################################
##  File:  python.sh
##  Desc:  Installs Python 2/3
################################################################################

set -e
# Source the helpers for use with the script
source $HELPER_SCRIPTS/os.sh

# Install Python, Python 3, pip, pip3
if isUbuntu16 || isUbuntu18; then
    apt-get install -y --no-install-recommends python python-dev python-pip python3 python3-dev python3-pip python3-venv
fi

if isUbuntu20; then
    apt-get install -y --no-install-recommends python3 python3-dev python3-pip python3-venv
    ln -s /usr/bin/pip3 /usr/bin/pip
fi

# Install pipx
# Set pipx custom directory
export PIPX_BIN_DIR=/opt/pipx_bin
export PIPX_HOME=/opt/pipx

python3 -m pip install pipx
python3 -m pipx ensurepath

echo "PIPX_BIN_DIR=$PIPX_BIN_DIR" | tee -a /etc/environment
echo "PIPX_HOME=$PIPX_HOME" | tee -a /etc/environment

# Add pipx bin directory to path
export PATH="$PATH:$PIPX_BIN_DIR"
echo 'export PATH="$PATH:/opt/pipx_bin"' >> /etc/skel/.bashrc

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
for cmd in python pip python3 pip3 pipx; do
    if ! command -v $cmd; then
        echo "$cmd was not installed or not found on PATH"
        exit 1
    fi
done
