#!/bin/bash -e -o pipefail
source ~/utils/utils.sh

echo Installing aws...
AWS_CLI_URL="https://awscli.amazonaws.com/AWSCLIV2.pkg"
download_with_retries $AWS_CLI_URL "/tmp"
sudo installer -pkg /tmp/AWSCLIV2.pkg -target /

echo Installing aws sam cli...
brew tap aws/tap
brew install aws-sam-cli

echo "Install aws cli session manager"
brew install --cask session-manager-plugin

invoke_tests "Common" "AWS"
