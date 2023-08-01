#!/bin/bash -e -o pipefail
source ~/utils/utils.sh

echo "Installing Microsoft Edge..."
brew install --cask microsoft-edge

EDGE_INSTALLATION_PATH="/Applications/Microsoft Edge.app/Contents/MacOS/Microsoft Edge"
EDGE_VERSION=$("$EDGE_INSTALLATION_PATH" --version | cut -d' ' -f 3)
EDGE_VERSION_MAJOR=$(echo $EDGE_VERSION | cut -d'.' -f 1)

echo "Version of Microsoft Edge: ${EDGE_VERSION}"

echo "Installing Microsoft Edge WebDriver..."

EDGE_DRIVER_VERSION_URL="https://msedgedriver.azureedge.net/LATEST_RELEASE_${EDGE_VERSION_MAJOR}_MACOS"
EDGE_DRIVER_LATEST_VERSION=$(curl -fsSL "$EDGE_DRIVER_VERSION_URL" | iconv -f utf-16 -t utf-8 | tr -d '\r')
EDGE_DRIVER_URL="https://msedgedriver.azureedge.net/${EDGE_DRIVER_LATEST_VERSION}/edgedriver_mac64.zip"

echo "Compatible version of WebDriver: ${EDGE_DRIVER_LATEST_VERSION}"

pushd "/tmp" > /dev/null
download_with_retries $EDGE_DRIVER_URL "." "edgedriver.zip"

# Move webdriver to the separate directory to be consistent with the docs
# https://docs.microsoft.com/en-us/azure/devops/pipelines/test/continuous-test-selenium?view=azure-devops#decide-how-you-will-deploy-and-test-your-app

APPLICATION="/usr/local/bin/msedgedriver"
EDGEDRIVER_DIR="/usr/local/share/edge_driver"
EDGEDRIVER_BIN="$EDGEDRIVER_DIR/msedgedriver"

mkdir -p $EDGEDRIVER_DIR

unzip "edgedriver.zip" -d $EDGEDRIVER_DIR
ln -s "$EDGEDRIVER_BIN" $APPLICATION
echo "export EDGEWEBDRIVER=${EDGEDRIVER_DIR}" >> "${HOME}/.bashrc"
popd > /dev/null

# Configure Edge Updater to prevent auto update
# https://learn.microsoft.com/en-us/deployedge/edge-learnmore-edgeupdater-for-macos

mkdir "Library/Managed Preferences"

cat <<EOF > "Library/Managed Preferences/com.microsoft.EdgeUpdater.plist"
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>updatePolicies</key>
    <dict>
        <key>global</key>
        <dict>
            <key>UpdateDefault</key>
            <integer>3</integer>
        </dict>
    </dict>
</dict>
</plist>
EOF

chown root:wheel "/Library/Managed Preferences/com.microsoft.EdgeUpdater.plist"

invoke_tests "Browsers" "Edge"
