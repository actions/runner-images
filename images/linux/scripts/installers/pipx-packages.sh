#!/bin/bash -e
################################################################################
##  File:  pipx-packages.sh
##  Desc:  Install tools via pipx
################################################################################
source $HELPER_SCRIPTS/install.sh

export PATH="$PATH:/opt/pipx_bin"

pipx_packages=$(get_toolset_value ".pipx[] .package")

for package in $pipx_packages; do
    python_version=$(get_toolset_value ".pipx[] | select(.package == \"$package\") .python")
    if [ "$python_version" != "null" ]; then
        python_path="/opt/hostedtoolcache/Python/$python_version*/x64/bin/python$python_version"
        echo "Install $package into python $python_path"
        pipx install $package --python $python_path
    else
        echo "Install $package into default python"
        pipx install $package
    fi

done

invoke_tests "Common" "PipxPackages"