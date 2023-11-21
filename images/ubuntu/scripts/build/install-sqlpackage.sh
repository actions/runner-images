#!/bin/bash -e
################################################################################
##  File:  install-sqlpackage.sh
##  Desc:  Install SqlPackage CLI to DacFx (https://docs.microsoft.com/sql/tools/sqlpackage/sqlpackage-download#get-sqlpackage-net-core-for-linux)
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh
source $HELPER_SCRIPTS/os.sh

# Install libssl1.1 dependency
if isUbuntu22; then
    download_with_retries "http://security.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.1f-1ubuntu2.20_amd64.deb" "/tmp"
    libssl_hash="0b3251aee55db6e20d02f4b9a2b703c9874a85ab6a20b12f4870f52f91633d37"
    use_checksum_comparison "/tmp/libssl1.1_1.1.1f-1ubuntu2.20_amd64.deb" "${libssl_hash}"
    dpkg -i /tmp/libssl1.1_1.1.1f-1ubuntu2.20_amd64.deb
fi

# Install SqlPackage
download_with_retries "https://aka.ms/sqlpackage-linux" "." "sqlpackage.zip"

unzip -qq sqlpackage.zip -d /usr/local/sqlpackage
rm -f sqlpackage.zip
chmod +x /usr/local/sqlpackage/sqlpackage
ln -sf /usr/local/sqlpackage/sqlpackage /usr/local/bin

invoke_tests "Tools" "SqlPackage"
