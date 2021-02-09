#!/bin/bash -e
################################################################################
##  File:  nodejs.sh
##  Desc:  Installs Node.js LTS and related tooling (Gulp, Grunt)
################################################################################

# Install LTS Node.js and related build tools
curl -sL https://raw.githubusercontent.com/mklement0/n-install/stable/bin/n-install | bash -s -- -ny -
~/n/bin/n lts
npm install -g grunt gulp n parcel-bundler typescript newman vercel
npm install -g --save-dev webpack webpack-cli

# Install the Netlify CLI using --unsafe-perm=true options to avoid permission issues
npm install -g --unsafe-perm=true netlify-cli

echo "Creating the symlink for [now] command to vercel CLI"
ln -s /usr/local/bin/vercel /usr/local/bin/now

rm -rf ~/n

# Install Yarn repository and key
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
apt-get update

# Install yarn
apt-get install -y --no-install-recommends yarn

invoke_tests "Tools" "Node.js"
