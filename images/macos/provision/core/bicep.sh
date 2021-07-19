#!/bin/bash -e -o pipefail

echo Installing bicep cli...
brew tap azure/bicep
brew install bicep

invoke_tests "Common" "Bicep"
