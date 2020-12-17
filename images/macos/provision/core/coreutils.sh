#!/bin/bash -e -o pipefail
source ~/utils/invoke-tests.sh

echo "Install curl"
brew install curl

echo "Install wget"
brew install wget

invoke_tests "Common" "Core utils"