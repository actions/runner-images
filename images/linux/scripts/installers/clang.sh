#!/bin/bash -e
################################################################################
##  File:  clang.sh
##  Desc:  Installs Clang compiler
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh

function InstallLLVMApt {
    echo "Installing apt.llvm.org repo..."

    curl -f -L --retry 5 https://apt.llvm.org/llvm-snapshot.gpg.key | gpg --dearmor -o /usr/share/keyrings/llvm-snapshot.gpg
    LSB_CODENAME=$(lsb_release -cs)
    {
        echo "deb [signed-by=/usr/share/keyrings/llvm-snapshot.gpg] https://apt.llvm.org/$LSB_CODENAME llvm-toolchain-$LSB_CODENAME main" 
        echo "deb [signed-by=/usr/share/keyrings/llvm-snapshot.gpg] https://apt.llvm.org/$LSB_CODENAME llvm-toolchain-$LSB_CODENAME-15 main" 
        echo "deb [signed-by=/usr/share/keyrings/llvm-snapshot.gpg] https://apt.llvm.org/$LSB_CODENAME llvm-toolchain-$LSB_CODENAME-14 main" 
        echo "deb [signed-by=/usr/share/keyrings/llvm-snapshot.gpg] https://apt.llvm.org/$LSB_CODENAME llvm-toolchain-$LSB_CODENAME-13 main"
    } >> /etc/apt/sources.list.d/llvm-toolchain.list
    apt update
}

function InstallClang {
    local version=$1

    echo "Installing clang-$version..."
    apt-get install -y "clang-$version" "lldb-$version" "lld-$version" "clang-format-$version" "clang-tidy-$version"
}

function SetDefaultClang {
    local version=$1

    echo "Make Clang ${version} default"
    update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-${version} 100
    update-alternatives --install /usr/bin/clang clang /usr/bin/clang-${version} 100
    update-alternatives --install /usr/bin/clang-format clang-format /usr/bin/clang-format-${version} 100
    update-alternatives --install /usr/bin/clang-tidy clang-tidy /usr/bin/clang-tidy-${version} 100
    update-alternatives --install /usr/bin/run-clang-tidy run-clang-tidy /usr/bin/run-clang-tidy-${version} 100
}

InstallLLVMApt

versions=$(get_toolset_value '.clang.versions[]')
default_clang_version=$(get_toolset_value '.clang.default_version')

for version in ${versions[*]}; do
    if [[ $version != $default_clang_version ]]; then
        InstallClang $version
    fi
done

InstallClang $default_clang_version
SetDefaultClang $default_clang_version

invoke_tests "Tools" "clang"
