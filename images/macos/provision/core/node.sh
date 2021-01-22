#!/bin/bash -e -o pipefail
source ~/utils/utils.sh

node_modules=(
  appcenter-cli
  newman
)

if is_Less_Catalina; then
  echo Installing the latest Node JS 8...
  TMP_FILE=/tmp/node-v8.17.0.pkg
  NODEURL=https://nodejs.org/dist/latest-v8.x/node-v8.17.0.pkg
  download_with_retries $NODEURL "/tmp"
  sudo installer -pkg "${TMP_FILE}" -target /
  rm -rf "${TMP_FILE}"
  sudo chown -R $USER "/usr/local/lib/node_modules"

  echo Installing NPM 3.x.x...
  npm install -g npm@3

  # This step is required to install App Center CLI
  echo Installing Omelette...
  npm install -g omelette@0.4.14

  echo Installing App Center CLI...
  npm install -g appcenter-cli@^1.0.0
else
  # Install Node.js 14 for macOS >= 10.15
  brew_smart_install "node@14"
  brew link node@14 --force

  for module in ${node_modules[@]}; do
    echo "Install $module"
    npm install -g $module
  done
fi

echo Installing yarn...
curl -o- -L https://yarnpkg.com/install.sh | bash

if is_Less_BigSur; then
  echo "Install node-gyp"
  npm install -g node-gyp
fi

invoke_tests "Node" "Node.js"
