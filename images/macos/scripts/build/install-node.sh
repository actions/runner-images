#!/bin/bash -e -o pipefail
################################################################################
##  File:  install-node.sh
##  Desc:  Install Node.js
################################################################################

source ~/utils/utils.sh

defaultVersion=$(get_toolset_value '.node.default')

echo "Installing Node.js $defaultVersion"
brew_smart_install "node@$defaultVersion"
brew link node@$defaultVersion --force --overwrite

echo Installing yarn...
yarn_installer_path=$(download_with_retry "https://yarnpkg.com/install.sh")
bash $yarn_installer_path

if is_Monterey; then
  npm_global_packages=$(get_toolset_value '.npm.global_packages[].name')
  for module in ${npm_global_packages[@]}; do
    echo "Install $module"
    npm install -g $module
done
fi

invoke_tests "Node" "Node.js"
