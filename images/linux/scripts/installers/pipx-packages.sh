#!/bin/bash
################################################################################
##  File:  pipx-packages.sh
##  Desc:  Install tools via pipx
################################################################################


export PATH="$PATH:/opt/pipx_bin"

toolset="$INSTALLER_SCRIPT_FOLDER/toolset.json"
pipx_packages=$(jq -r ".pipx[]" $toolset)

for package in $pipx_packages; do
    echo "Install $package"
    pipx install $package
done

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
for cmd in $pipx_packages; do
    if ! command -v $cmd; then
        echo "$cmd was not installed"
        exit 1
    fi
done
