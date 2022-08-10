#!/bin/bash -e -o pipefail
source ~/utils/utils.sh

gccVersions=$(get_toolset_value '.gcc.versions | .[]')

for gccVersion in $gccVersions; do
    brew_smart_install "gcc@${gccVersion}"
done

# Delete default gfortran link if it exists https://github.com/actions/runner-images/issues/1280
gfortranPath=$(which gfortran)
if [ $gfortranPath ]; then
    rm $gfortranPath
fi

invoke_tests "Common" "GCC"
