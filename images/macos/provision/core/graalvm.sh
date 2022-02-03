#!/bin/bash -e -o pipefail
source ~/utils/utils.sh

echo Installing GraalVM...
brew install --cask graalvm/tap/graalvm-ce-java11

exportPath=$(echo /Library/Java/JavaVirtualMachines/graalvm-ce-java*/Contents/Home/bin)
echo "Setting up GRAALVM_11_ROOT variable to ${exportPath}"
echo "export GRAALVM_11_ROOT=${exportPath}" >> "${HOME}/.bashrc"

# GraalVM not being signed and notarized yet on macOS Catalina
if is_Catalina; then
    quarantinePath=$(echo /Library/Java/JavaVirtualMachines/graalvm-ce-java*)
    sudo xattr -rd com.apple.quarantine $quarantinePath
fi

# Install Native Image
$exportPath/gu install native-image

invoke_tests "Common" "GraalVM"