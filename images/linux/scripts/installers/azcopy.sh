#!/bin/bash
################################################################################
##  File:  azcopy.sh
##  Desc:  Installs AzCopy
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh

# Install AzCopy7
wget -O azcopy.tar.gz https://aka.ms/downloadazcopylinux64
tar -xf azcopy.tar.gz
rm azcopy.tar.gz
./install.sh

# Install AzCopy10
wget -O /tmp/azcopy.tar.gz https://aka.ms/downloadazcopy-v10-linux
tar zxvf /tmp/azcopy.tar.gz --strip-components=1 -C /tmp
mv /tmp/azcopy /usr/local/bin/azcopy10
chmod +x /usr/local/bin/azcopy10

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
if ! command -v azcopy; then
    echo "azcopy7 was not installed"
    exit 1
fi

if ! command -v azcopy10; then
    echo "azcopy10 was not installed"
    exit 1
fi

# Document what was added to the image
azcopy7Version=$(azcopy --version | awk '{print $2}' | cut -d '-' -f 1)
azcopy10Version=$(azcopy10 --version | awk '{print $3}')
echo "Lastly, documenting what we added to the metadata file"
DocumentInstalledItem "AzCopy7 (available by azcopy alias) $azcopy7Version"
DocumentInstalledItem "AzCopy10 (available by azcopy10 alias) $azcopy10Version"
