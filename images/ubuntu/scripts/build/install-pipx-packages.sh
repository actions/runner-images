#!/bin/bash -e
################################################################################
##  File:  install-pipx-packages.sh
##  Desc:  Install tools via pipx
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh

export PIPX_BIN_DIR="/opt/pipx_bin"
export PIPX_HOME="/opt/pipx"
export PATH="$PATH:$PIPX_BIN_DIR:$HOME/.local/bin"
python3 -m pipx ensurepath >/dev/null 2>&1 || true

pipx_packages=$(get_toolset_value '.pipx.packages[].package')

if [[ -z "$pipx_packages" ]]; then
    echo "No pipx packages defined in the active toolset. Skipping installation and validation."
    exit 0
fi

for package in $pipx_packages; do
    echo "Install $package into default python"
    pipx install $package

    # https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html
    # Install ansible into an existing ansible-core Virtual Environment
    if [[ $package == "ansible-core" ]]; then
        pipx inject $package ansible
    fi
done

invoke_tests "Common" "PipxPackages"
