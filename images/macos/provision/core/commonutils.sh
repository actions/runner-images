#!/bin/bash -e -o pipefail

source ~/utils/utils.sh

# TO-DO: Move the list of brew packages and casks to toolset

# brew install
binst_common_utils=(
    carthage
    cmake
    subversion
    go
    gnupg
    llvm
    libpq
    zstd
    packer
    helm
    aliyun-cli
    bazelisk
    gh
    p7zip
    ant
    aria2
    gnu-tar
)

if is_Less_BigSur; then
    binst_common_utils+=(
        xctool
        bats
        parallel
    )
fi

for package in ${binst_common_utils[@]}; do
    echo "Install $package"
    brew install $package
done

# brew cask install
bcask_common_utils=(
    julia
)

if is_Less_BigSur; then
    bcask_common_utils+=(
        virtualbox
        vagrant
        r
    )
fi

for package in ${bcask_common_utils[@]}; do
    echo "Install $package"
    brew install --cask $package
done

# Invoke bazel to download the latest bazel version via bazelisk
bazel
