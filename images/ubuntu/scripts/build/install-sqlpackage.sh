#!/bin/bash -e
################################################################################
##  File:  install-sqlpackage.sh
##  Desc:  Install SqlPackage CLI to DacFx (https://docs.microsoft.com/sql/tools/sqlpackage/sqlpackage-download#get-sqlpackage-net-core-for-linux)
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh
source $HELPER_SCRIPTS/os.sh

# Install libssl1.1 dependency
if is_ubuntu22; then
    focal_list=/etc/apt/sources.list.d/focal-security.list
    echo "deb http://archive.ubuntu.com/ubuntu/ focal-security main" | tee "${focal_list}"
    apt-get update --quiet

    apt-get install --no-install-recommends libssl1.1

    rm "${focal_list}"
    apt-get update --quiet
fi

# Install SqlPackage
archive_path=$(download_with_retry "https://aka.ms/sqlpackage-linux")
unzip -qq "$archive_path" -d /usr/local/sqlpackage
chmod +x /usr/local/sqlpackage/sqlpackage
ln -sf /usr/local/sqlpackage/sqlpackage /usr/local/bin

invoke_tests "Tools" "SqlPackage"
