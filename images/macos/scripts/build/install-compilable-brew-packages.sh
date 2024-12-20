#!/bin/bash -e -o pipefail
################################################################################
##  File:  install-compilable-brew-packages.sh
##  Desc:  Install compilable brew packages
################################################################################

source ~/utils/utils.sh

compilable_packages=$(get_toolset_value '.brew.compilable_packages[]')
for package in $compilable_packages; do
    echo "Installing $package..."
    brew_smart_install "$package"
done

invoke_tests "Common" "Compiled"
