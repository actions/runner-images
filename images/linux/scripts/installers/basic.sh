#!/bin/bash -e
################################################################################
##  File:  basic.sh
##  Desc:  Installs basic command line utilities and dev packages
################################################################################
source $HELPER_SCRIPTS/install.sh
source $HELPER_SCRIPTS/os.sh

common_packages=$(get_toolset_value .apt.common_packages[])
cmd_packages=$(get_toolset_value .apt.cmd_packages[])
for package in $common_packages $cmd_packages; do
    echo "Install $package"
    apt-get install -y --no-install-recommends $package
done

# Toolcache Python requires updated libssl-dev, which was previously installed from ppa:ondrej.
# The ppa dropped Ubuntu 16 support hence we need to build OpenSSL from source
if isUbuntu16; then
    openSslArchiveName="openssl-1.1.1k.tar.gz"
    openSslUrl="https://www.openssl.org/source/${openSslArchiveName}"
    download_with_retries $openSslUrl "/tmp"
    openSslPath="/tmp/$(basename -s .tar.gz $openSslArchiveName)"
    mkdir -p "$openSslPath"
    tar -C "$openSslPath" -xzf "/tmp/${openSslArchiveName}" --strip-components=1 && cd $openSslPath
    ./config --openssldir=/etc/ssl '-Wl,--enable-new-dtags,-rpath,$(LIBRPATH)'
    make -s
    make install > /dev/null
    ln -sf /etc/ssl/bin/openssl /usr/bin/openssl
fi

invoke_tests "Apt"