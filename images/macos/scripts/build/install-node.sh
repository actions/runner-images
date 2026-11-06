#!/bin/bash -e -o pipefail
################################################################################
##  File:  install-node.sh
##  Desc:  Install Node.js
################################################################################

source ~/utils/utils.sh

defaultVersion=$(get_toolset_value '.node.default')

if ! is_Arm64; then
    # Node dependency simdjson is not available for Intel macOS images since 2026.08.31
    COMMIT=e13ded35d324fe5e3eb9ac4d3c2be05cab13cf72
    FILE_NAME="s/simdjson.rb"
    FORMULA_NAME="simdjson"
    brew_install_pinned_formula "$FORMULA_NAME" "$FILE_NAME" "$COMMIT"
fi

echo "Installing Node.js $defaultVersion"
brew_smart_install "node@$defaultVersion"
HOMEBREW_NO_AUTO_UPDATE=1 brew upgrade "node@$defaultVersion"
brew link node@$defaultVersion --force --overwrite
node <<'NODE'
const [major, minor, patch] = process.versions.node.split(".").map(Number);
const minimum = {22: [23, 4], 24: [22, 1], 26: [12, 1]}[major];
if (!minimum || minor < minimum[0] || (minor === minimum[0] && patch < minimum[1])) process.exit(1);
NODE

echo Installing yarn...
yarn_installer_path=$(download_with_retry "https://yarnpkg.com/install.sh")
bash $yarn_installer_path

invoke_tests "Node" "Node.js"
