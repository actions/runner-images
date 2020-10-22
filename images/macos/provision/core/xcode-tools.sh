#!/bin/sh

# The script currently requires 2 external variables to be set: XCODE_INSTALL_USER
# and XCODE_INSTALL_PASSWORD, in order to access the Apple Developer Center

set -e

source ~/utils/utils.sh
source ~/utils/xcode-utils.sh

if [ -z $XCODE_INSTALL_USER ] || [ -z $XCODE_INSTALL_PASSWORD ]; then
    echo "Required environment variables XCODE_INSTALL_USER and XCODE_INSTALL_PASSWORD are not set"
    exit 1
fi

XCODE_COUNT=$(get_toolset_value '.xcode.versions | length')
XCODE_LOCAL_LIST=$(get_toolset_value '.xcode.versions[].localVersion')
DEFAULT_XCODE_VERSION=$(get_toolset_value '.xcode.default')
WORK_DIR="${HOME}/Library/Caches/XcodeInstall"

# Update the list of available versions
xcversion update

for ((XCODE_INDEX=0; XCODE_INDEX<XCODE_COUNT; XCODE_INDEX++)); do
    LOCAL_VERSION=$(get_toolset_value ".xcode.versions[$XCODE_INDEX].localVersion")
    XCODE_VERSION=$(get_toolset_value ".xcode.versions[$XCODE_INDEX].version")
    SYMLINKS=($(get_toolset_value ".xcode.versions[$XCODE_INDEX].symlinks"))

    echo "Installing Xcode '$XCODE_VERSION' to '/Applications/Xcode_${LOCAL_VERSION}.app'"
    downloadXcode $XCODE_VERSION

    echo "Extracting Xcode.app ($VERSION_TO_INSTALL) to ${WORK_DIR} ..."
    extractXcodeXip $WORK_DIR

    echo "Validating unpacked Xcode ${XCODE_VERSION}"
    validateXcodeIntegrity "$WORK_DIR"

    echo "Copying Xcode.app to /Applications/Xcode_${LOCAL_VERSION}.app"
    mv -f "${WORK_DIR}/Xcode.app" "/Applications/Xcode_${LOCAL_VERSION}.app"

    echo "Accepting license for Xcode ${XCODE_VERSION}..."
    approveXcodeLicense "$LOCAL_VERSION"

    echo "Creating symlinks..."
    createXcodeSymlinks $LOCAL_VERSION $SYMLINKS

    find $WORK_DIR -mindepth 1 -delete
done

echo "Running 'runFirstLaunch' for all Xcode versions"
runFirstLaunchXcodeList $XCODE_LOCAL_LIST

echo "Running 'runFirstLaunch' for default Xcode ${DEFAULT_XCODE_VERSION}..."
runFirstLaunch $DEFAULT_XCODE_VERSION

echo "Setting Xcode ${DEFAULT_XCODE_VERSION} as default"
sudo xcode-select -s "/Applications/Xcode_${DEFAULT_XCODE_VERSION}.app/Contents/Developer"

echo "Adding symlink '/Applications/Xcode_${DEFAULT_XCODE_VERSION}.app' -> '/Applications/Xcode.app'"
ln -s "/Applications/Xcode_${DEFAULT_XCODE_VERSION}.app" "/Applications/Xcode.app"

echo "Enabling developer mode"
sudo /usr/sbin/DevToolsSecurity --enable

echo "Setting environment variables 'XCODE_<VERSION>_DEVELOPER_DIR'"
setXcodeDeveloperDirVariables

echo "Doing cleanup. Emptying ${WORK_DIR}..."
rm -rf "$WORK_DIR"
