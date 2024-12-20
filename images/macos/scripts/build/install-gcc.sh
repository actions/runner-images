#!/bin/bash -e -o pipefail
################################################################################
##  File:  install-gcc.sh
##  Desc:  Install GCC
################################################################################

source ~/utils/utils.sh

gccVersions=$(get_toolset_value '.gcc.versions | .[]')

for gccVersion in $gccVersions; do
    brew_smart_install "gcc@${gccVersion}"
done

# Delete default gfortran link if it exists https://github.com/actions/runner-images/issues/1280
gfortranPath=$(which gfortran) || true
if [[ $gfortranPath ]]; then
    rm $gfortranPath
fi

invoke_tests "Common" "GCC"
