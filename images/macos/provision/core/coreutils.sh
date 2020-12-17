#!/bin/bash -e -o pipefail

echo "Install curl"
brew install curl

echo "Install wget"
brew install wget

echo "Install jq"
brew install jq

invoke_tests "Common" "Core utils"