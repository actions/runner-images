#!/bin/bash -e -o pipefail

################################################################################
##  File:  mono.sh
##  Desc:  Installs Mono Framework
################################################################################

# Source utility functions
source ~/utils/utils.sh

# Create a temporary directory to store downloaded files
TMP_DIR=$(mktemp -d /tmp/visualstudio.XXXX)

# Install Mono Framework
MONO_VERSION_FULL=$(get_toolset_value '.mono.framework.version')
MONO_VERSION=$(echo "$MONO_VERSION_FULL" | cut -d. -f 1,2,3)
MONO_VERSION_SHORT=$(echo $MONO_VERSION_FULL | cut -d. -f 1,2)
MONO_PKG_URL="https://download.mono-project.com/archive/${MONO_VERSION}/macos-10-universal/MonoFramework-MDK-${MONO_VERSION_FULL}.macos10.xamarin.universal.pkg"
MONO_PKG_NAME=${MONO_PKG_URL##*/}
MONO_VERSIONS_PATH='/Library/Frameworks/Mono.framework/Versions'

download_with_retries "$MONO_PKG_URL" "$TMP_DIR"
echo "Installing $MONO_PKG_NAME..."
sudo installer -pkg "$TMP_DIR/$MONO_PKG_NAME" -target /

# Download and install NUnit console
NUNIT_VERSION=$(get_toolset_value '.mono.nunit.version')
NUNIT_ARCHIVE_URL="https://github.com/nunit/nunit-console/releases/download/${NUNIT_VERSION}/NUnit.Console-${NUNIT_VERSION}.zip"
NUNIT_ARCHIVE_NAME=${NUNIT_ARCHIVE_URL##*/}
NUNIT_PATH="/Library/Developer/nunit"
NUNIT_VERSION_PATH="$NUNIT_PATH/$NUNIT_VERSION"

download_with_retries "$NUNIT_ARCHIVE_URL" "$TMP_DIR"
echo "Installing $NUNIT_ARCHIVE_NAME..."
sudo mkdir -p "$NUNIT_VERSION_PATH"
sudo unzip -q "$TMP_DIR/$NUNIT_ARCHIVE_NAME" -d "$NUNIT_VERSION_PATH"

# Create a wrapper script for nunit3-console
echo "Creating nunit3-console wrapper..."
NUNIT3_CONSOLE_WRAPPER=nunit3-console
cat <<EOF > "${TMP_DIR}/${NUNIT3_CONSOLE_WRAPPER}"
#!/bin/bash -e -o pipefail
exec ${MONO_VERSIONS_PATH}/${MONO_VERSION}/bin/mono --debug \$MONO_OPTIONS $NUNIT_VERSION_PATH/nunit3-console.exe "\$@"
EOF
cat "${TMP_DIR}/${NUNIT3_CONSOLE_WRAPPER}"
sudo chmod +x "${TMP_DIR}/${NUNIT3_CONSOLE_WRAPPER}"
sudo mv "${TMP_DIR}/${NUNIT3_CONSOLE_WRAPPER}" "${MONO_VERSIONS_PATH}/${MONO_VERSION}/Commands/${NUNIT3_CONSOLE_WRAPPER}"

# Create a symlink for the short version of Mono (e.g., 6.12)
echo "Creating short symlink '${MONO_VERSION_SHORT}'..."
sudo ln -s "${MONO_VERSIONS_PATH}/${MONO_VERSION}" "${MONO_VERSIONS_PATH}/${MONO_VERSION_SHORT}"

# Invoke tests for Xamarin and Mono
invoke_tests "Xamarin" "Mono"
