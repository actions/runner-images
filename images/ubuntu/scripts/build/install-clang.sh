#!/bin/bash -e
################################################################################
##  File:  install-clang.sh
##  Desc:  Install Clang compiler
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh
source $HELPER_SCRIPTS/os.sh

install_clang() {
    local version=$1

    echo "Installing clang-$version..."
    apt-get install "clang-$version" "lldb-$version" "lld-$version" "clang-format-$version" "clang-tidy-$version"
    if is_ubuntu22_arm64 || is_ubuntu24_arm64; then
        apt-get install "llvm-$version"
    fi
}

set_default_clang() {
    local version=$1

    echo "Make Clang ${version} default"
    update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-${version} 100
    update-alternatives --install /usr/bin/clang clang /usr/bin/clang-${version} 100
    update-alternatives --install /usr/bin/clang-format clang-format /usr/bin/clang-format-${version} 100
    update-alternatives --install /usr/bin/clang-tidy clang-tidy /usr/bin/clang-tidy-${version} 100
    update-alternatives --install /usr/bin/run-clang-tidy run-clang-tidy /usr/bin/run-clang-tidy-${version} 100
    if is_ubuntu22_arm64 || is_ubuntu24_arm64; then
        update-alternatives --install /usr/bin/llvm-config llvm-config /usr/bin/llvm-config-${version} 100
    fi
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
