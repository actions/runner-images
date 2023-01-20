#!/bin/bash -e -o pipefail
source ~/utils/utils.sh

echo Installing aws...
brew install awscli

echo Installing aws sam cli...
brew install aws-sam-cli

echo "Install aws cli session manager"
brew install --cask session-manager-plugin

invoke_tests "Common" "AWS"
