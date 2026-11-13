#!/bin/bash -e
################################################################################
##  File:  install-apt-vital.sh
##  Desc:  Install vital command line utilities
################################################################################

# Source the helpers for use with the script
set -e
source $HELPER_SCRIPTS/install.sh

# Refresh the vendor trust store before downloading the remaining tools.
source /etc/os-release
case "$VERSION_ID" in
    22.04|24.04) minimum_ca_version="20260816ubuntu0.${VERSION_ID}.1" ;;
    *) minimum_ca_version="" ;;
esac
apt-get update
apt-get install -y --no-install-recommends ca-certificates
if [[ -n "$minimum_ca_version" ]]; then
    dpkg --compare-versions "$(dpkg-query -W -f='${Version}' ca-certificates)" ge "$minimum_ca_version"
fi
update-ca-certificates

vital_packages=$(get_toolset_value .apt.vital_packages[])
apt-get install --no-install-recommends $vital_packages
