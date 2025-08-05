#!/bin/bash -e -o pipefail
################################################################################
##  File:  install-unxip.sh
##  Desc:  Install unxip
################################################################################

source ~/utils/utils.sh

echo "Installing unxip..."
unxip_pkg=$(download_with_retry "https://github.com/saagarjha/unxip/releases/download/v3.1/unxip")
unxip_pkg_sha256="926ecd7bffa201c7b2b8a729fc70fbf228cf624a0e6856c13f935a97fa4fc71a"
use_checksum_comparison $unxip_pkg $unxip_pkg_sha256
install "$unxip_pkg" /usr/local/bin/unxip

invoke_tests "Common" "Unxip"
