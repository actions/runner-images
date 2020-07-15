#!/bin/bash
################################################################################
##  File:  clang.sh
##  Desc:  Installs Clang compiler (versions: 6, 8 and 9)
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh

function InstallClang {
    version=$1

    echo "Installing clang-$version..."
    if [[ $version =~ 9 ]]; then
        ./llvm.sh $version
        apt-get install -y "clang-format-$version"
    else
        apt-get install -y "clang-$version" "lldb-$version" "lld-$version" "clang-format-$version"
    fi

    # Run tests to determine that the software installed as expected
    echo "Testing to make sure that script performed as expected, and basic scenarios work"
    for cmd in clang-$version clang++-$version; do
        if ! command -v $cmd; then
            echo "$cmd was not installed"
            exit 1
        fi
    done

    # Document what was added to the image
    echo "Documenting clang-$version..."
    DocumentInstalledItem "Clang $version ($(clang-$version --version | head -n 1 | cut -d ' ' -f 3 | cut -d '-' -f 1))"
}

# Download script for automatic installation
wget https://apt.llvm.org/llvm.sh
chmod +x llvm.sh

versions=(
    "6.0"
    "8"
    "9"
)

for version in ${versions[*]}
do
    InstallClang $version
done

rm llvm.sh

# Make Clang 9 default
update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-9 100
update-alternatives --install /usr/bin/clang clang /usr/bin/clang-9 100
update-alternatives --install /usr/bin/clang-format clang-format /usr/bin/clang-format-9 100
