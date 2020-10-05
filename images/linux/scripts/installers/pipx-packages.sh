#!/bin/bash
################################################################################
##  File:  pipx-packages.sh
##  Desc:  Install tools via pipx
################################################################################


export PATH="$PATH:/opt/pipx_bin"

toolset="$INSTALLER_SCRIPT_FOLDER/toolset.json"
pipx_packages=$(jq ".pipx[] .package" $toolset)

for package in $pipx_packages; do
    python_path=$(jq ".pipx[] | select(.package == $package) .python" $toolset)
    if [ "$python_path" = "default" ]; then
        echo "Install $package into default python"
        pipx install $package
    else
        echo "Install $package into python $python_path"
        pipx install $package --python $python_path
    fi

    # Run tests to determine that the software installed as expected
    cmd=$(jq ".pipx[] | select(.package == $package) .cmd" $toolset)
    if ! command -v $cmd; then
        echo "$package was not installed"
        exit 1
    fi
done
