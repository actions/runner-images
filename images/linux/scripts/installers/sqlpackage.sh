#!/bin/bash -e
################################################################################
##  File:  sqlpackage.sh
##  Desc:  Install SqlPackage CLI to DacFx (https://docs.microsoft.com/sql/tools/sqlpackage/sqlpackage-download#get-sqlpackage-net-core-for-linux)
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh
source $HELPER_SCRIPTS/os.sh

# Install libssl1.1 dependency
if isUbuntu22; then
    # Collect info about openssl releases, filtering out the latest one libssl1.1 deb package for amd64, cut name prefix for a link
    base_url="http://security.ubuntu.com/ubuntu/pool/main/o/openssl"
    deb_name_prefix=$(curl -s "${base_url}" | grep -o '"libssl1\.1_1\.1\.[0-9][a-z]-[0-9]ubuntu[0-9].*_amd64\.deb"' | sed 's/"//g' | sed 's/_amd64.deb//g' | sort -V | tail -n 1)
    download_with_retries "${base_url}/${deb_name_prefix}_amd64.deb" "/tmp"
    dpkg -i "/tmp/${deb_name_prefix}_amd64.deb"
fi

# Install SqlPackage
download_with_retries "https://aka.ms/sqlpackage-linux" "." "sqlpackage.zip"

unzip -qq sqlpackage.zip -d /usr/local/sqlpackage
rm -f sqlpackage.zip
chmod +x /usr/local/sqlpackage/sqlpackage
ln -sf /usr/local/sqlpackage/sqlpackage /usr/local/bin

invoke_tests "Tools" "SqlPackage"
