#!/bin/bash -e

################################################################################
##  File:  mono.sh
##  Desc:  Installs Mono Framework
################################################################################

source ~/utils/utils.sh

TMP_DIR=$(mktemp -d /tmp/visualstudio.XXXX)

# Install Mono Framework
MONO_VERSION_FULL=$(get_toolset_value '.mono.framework.version')
MONO_VERSION=$(echo "$MONO_VERSION_FULL" | cut -d. -f 1,2,3)
MONO_VERSION_SHORT=$(echo $MONO_VERSION_FULL | cut -d. -f 1,2)
MONO_PKG_URL="https://download.mono-project.com/archive/${MONO_VERSION}/macos-10-universal/MonoFramework-MDK-${VERSION}.macos10.xamarin.universal.pkg"
MONO_PKG_NAME=${MONO_PKG_URL##*/}
MONO_VERSIONS_PATH='/Library/Frameworks/Mono.framework/Versions'

download_with_retries "$MONO_PKG_URL" "$TMP_DIR"
echo "Installing $MONO_PKG_NAME..."
sudo installer -pkg "$TMP_DIR/$MONO_PKG_NAME" -target /

# Download and install NUnit console
NUNIT_VERSION=$(get_toolset_value '.mono.nunit.version')
NUNIT_ARCHIVE_URL="https://github.com/nunit/nunit-console/releases/download/${NUNIT_VERSION}/NUnit.Console-{$NUNIT_VERSION}.zip"
NUNIT_ARCHIVE_NAME=${NUNIT_ARCHIVE_URL##*/}
NUNIT_PATH="/Library/Developer/nunit"
NUNIT_VERSION_PATH="$NUNIT_PATH/$NUNIT_VERSION"

download_with_retries "$NUNIT_ARCHIVE_URL" "$TMP_DIR"
echo "Installing $NUNIT_ARCHIVE_NAME..."
sudo mkdir -p "$NUNIT_VERSION_PATH"
sudo unzip "$NUNIT_ARCHIVE_NAME" -d "$NUNIT_VERSION_PATH"

echo "Creating nunit3-console wrapper..."
NUNIT3_CONSOLE_WRAPPER=nunit3-console
cat <<EOF > "${TMP_DIR}/${NUNIT3_CONSOLE_WRAPPER}"
#!/bin/bash -e -o pipefail
exec /Library/Frameworks/Mono.framework/Versions/${MONO_VERSION_FULL}/bin/mono --debug \$MONO_OPTIONS $NUNIT_VERSION_PATH/nunit3-console.exe "\$@"
EOF
sudo chmod +x "${TMP_DIR}/${NUNIT3_CONSOLE_WRAPPER}"
sudo mv "${TMP_DIR}/${NUNIT3_CONSOLE_WRAPPER}" "${MONO_VERSIONS_PATH}/${MONO_VERSION_FULL}/Commands/${NUNIT3_CONSOLE_WRAPPER}"

echo "Creating short symlink '${MONO_VERSION_SHORT}'..."
sudo ln -s "${MONO_VERSIONS_PATH}/${MONO_VERSION}" "${MONO_VERSIONS_PATH}/${MONO_VERSION_SHORT}"

invoke_tests "Xamarin" "Mono"
