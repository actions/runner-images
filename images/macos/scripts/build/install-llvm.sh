#!/bin/bash -e -o pipefail
################################################################################
##  File:  install-llvm.sh
##  Desc:  Install LLVM
################################################################################

source ~/utils/utils.sh

echo "[DEBUG] which clang:   $(which clang)"
echo "[DEBUG] which clang++: $(which clang++)"
clang --version
clang++ --version

llvmVersion=$(get_toolset_value '.llvm.version')
llvmSkipLink=$(get_toolset_value '.llvm.skip_link')

brew_smart_install "llvm@${llvmVersion}" "$llvmSkipLink"

echo "[DEBUG] which clang:   $(which clang)"
echo "[DEBUG] which clang++: $(which clang++)"
clang --version
clang++ --version

invoke_tests "LLVM"
