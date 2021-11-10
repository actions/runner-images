#!/bin/bash -e -o pipefail
source ~/utils/utils.sh

if is_Less_Catalina; then
  echo Installing the latest Node JS 8...
  TMP_FILE=/tmp/node-v8.17.0.pkg
  NODEURL=https://nodejs.org/dist/latest-v8.x/node-v8.17.0.pkg
  download_with_retries $NODEURL "/tmp"
  sudo installer -pkg "${TMP_FILE}" -target /
  rm -rf "${TMP_FILE}"
  sudo chown -R $USER "/usr/local/lib/node_modules"
else
  # Install default Node.js for macOS >= 10.15
  defaultVersion=$(get_toolset_value '.node.default')

  echo "Installing Node.js $defaultVersion"
  brew_smart_install "node@$defaultVersion"
  brew link node@$defaultVersion --force
fi

echo Installing yarn...
curl -o- -L https://yarnpkg.com/install.sh | bash

npm_global_packages=$(get_toolset_value '.npm.global_packages[].name')
for module in ${npm_global_packages[@]}; do
  echo "Install $module"
  npm install -g $module
done

invoke_tests "Node" "Node.js"
