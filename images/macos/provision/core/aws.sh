#!/bin/bash

echo Installing aws...
brew install awscli

echo Installing aws sam cli...
brew tap aws/tap

# Workaround for broken aws-sam-cli formula after this pr https://github.com/aws/homebrew-tap/pull/138
cd "$(brew --repo aws/tap)"
currentCommitId=$(git rev-parse --short HEAD)
brokenCommitId="9d91002"
if [ $currentCommitId == $brokenCommitId ]; then
    # Checkout the latest working commit
    git checkout b5b3afed932d
fi

brew install aws-sam-cli

echo "Install aws cli session manager"
brew cask install session-manager-plugin
