#!/bin/bash
################################################################################
##  File:  pulumi.sh
##  Desc:  Installs Pulumi
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh

# Install Pulumi
VERSION=$(curl --fail --silent -L "https://www.pulumi.com/latest-version")
TARBALL_URL="https://get.pulumi.com/releases/sdk/pulumi-v${VERSION}-linux-x64.tar.gz"
TARBALL_DEST=$(mktemp -t pulumi.tar.gz.XXXXXXXXXX)
curl -L -o "${TARBALL_DEST}" "${TARBALL_URL}"
EXTRACT_DIR=$(mktemp -d pulumi.XXXXXXXXXX)
tar zxf "${TARBALL_DEST}" -C "${EXTRACT_DIR}"
if [ -d "${EXTRACT_DIR}/pulumi/bin" ]; then
    mv "${EXTRACT_DIR}/pulumi/bin" "/usr/local/bin/"
else
    cp -r "${EXTRACT_DIR}/pulumi/." "/usr/local/bin/"
fi
rm -rf ${TARBALL_DEST} ${EXTRACT_DIR}

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
if ! command -v pulumi ; then
    echo "Pulumi was not installed"
    exit 1
fi

# Document what was added to the image
pulumi_version="$(pulumi version)"
echo "Lastly, documenting what we added to the metadata file"
DocumentInstalledItem "Pulumi ($pulumi_version)"