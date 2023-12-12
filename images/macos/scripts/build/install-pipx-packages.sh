#!/bin/bash -e -o pipefail
################################################################################
##  File:  install-pipx-packages.sh
##  Desc:  Install Pipx Packages
################################################################################

source ~/utils/utils.sh

export PATH="$PATH:/opt/pipx_bin"

pipx_packages=$(get_toolset_value '.pipx[].package') #'.android.platform_min_version'

for package in $pipx_packages; do
    python_version="$(get_toolset_value ".pipx[] | select(.package==\"$package\") | .python[]?")"
    if [ "$python_version" != "null" ]; then
        python_path="$HOME/hostedtoolcache/Python/$python_version*/x64/bin/python$python_version"
        echo "Install $package into python $python_path"
        pipx install $package --python $python_path
    else
        echo "Install $package into default python"
        pipx install $package
    fi
done

invoke_tests "PipxPackages"
