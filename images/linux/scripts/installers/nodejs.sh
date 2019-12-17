#!/bin/bash
################################################################################
##  File:  nodejs.sh
##  Desc:  Installs Node.js LTS and related tooling (Gulp, Grunt)
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh

# Install LTS Node.js and related build tools
curl -sL https://git.io/n-install | bash -s -- -ny -
~/n/bin/n lts
npm install -g grunt gulp n parcel-bundler typescript
npm install -g --save-dev webpack webpack-cli
npm install -g npm
rm -rf ~/n

# Install Yarn repository and key
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
apt-get update

# Install yarn
apt-get install -y --no-install-recommends yarn

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
for cmd in node grunt gulp webpack parcel yarn; do
    if ! command -v $cmd; then
        echo "$cmd was not installed"
        exit 1
    fi
done

# Document what was added to the image
echo "Lastly, documenting what we added to the metadata file"
DocumentInstalledItem "Node.js ($(node --version))"
DocumentInstalledItem "Grunt ($(grunt --version))"
DocumentInstalledItem "Gulp ($(gulp --version))"
DocumentInstalledItem "n ($(n --version))"
DocumentInstalledItem "Parcel ($(parcel --version))"
DocumentInstalledItem "TypeScript ($(tsc --version))"
DocumentInstalledItem "Webpack ($(webpack --version))"
DocumentInstalledItem "Webpack CLI ($(webpack-cli --version))"
DocumentInstalledItem "Yarn ($(yarn --version))"
