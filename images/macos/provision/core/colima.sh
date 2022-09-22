#!/bin/bash -e -o pipefail

echo Installing Colima...
brew install colima

invoke_tests "Common" "Colima"