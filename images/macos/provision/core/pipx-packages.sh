#!/bin/bash -e -o pipefail
source ~/utils/utils.sh

export PATH="$PATH:/opt/pipx_bin"

toolset=$(get_toolset_path)
pipx_packages=$(jq -r ".pipx[] .package" $toolset)

for package in $pipx_packages; do
    python_version=$(jq -r ".pipx[] | select(.package == \"$package\") .python" $toolset)
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
