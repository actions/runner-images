#!/bin/bash -e
################################################################################
##  File:  install-clang.sh
##  Desc:  Install Clang compiler
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh

install_clang() {
    local version=$1

    echo "Installing clang-$version..."
    apt-get install "clang-$version" "lldb-$version" "lld-$version" "clang-format-$version" "clang-tidy-$version"
}

set_default_clang() {
    local version=$1

    echo "Make Clang ${version} default"
    update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-${version} 100
    update-alternatives --install /usr/bin/clang clang /usr/bin/clang-${version} 100
    update-alternatives --install /usr/bin/clang-format clang-format /usr/bin/clang-format-${version} 100
    update-alternatives --install /usr/bin/clang-tidy clang-tidy /usr/bin/clang-tidy-${version} 100
    update-alternatives --install /usr/bin/run-clang-tidy run-clang-tidy /usr/bin/run-clang-tidy-${version} 100
}

versions=$(get_toolset_value '.clang.versions[]')
default_clang_version=$(get_toolset_value '.clang.default_version')

for version in ${versions[*]}; do
    if [[ $version != $default_clang_version ]]; then
        install_clang $version
    fi
done

install_clang $default_clang_version
set_default_clang $default_clang_version

invoke_tests "Tools" "clang"
