#!/bin/bash -e -o pipefail

source ~/utils/utils.sh

echo Installing bicep cli...
brew tap azure/bicep
brew_smart_install bicep

invoke_tests "Common" "Bicep"
