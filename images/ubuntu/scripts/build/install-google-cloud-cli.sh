#!/bin/bash -e
################################################################################
##  File:  install-google-cloud-cli.sh
##  Desc:  Install the Google Cloud CLI
################################################################################

source $HELPER_SCRIPTS/install.sh
source $HELPER_SCRIPTS/os.sh

REPO_URL="https://packages.cloud.google.com/apt"

if is_ubuntu26_arm64; then
    # Install from tarball, ubuntu 26.04 arm64 package from apt requires python3 < 3.14
    tarball_url="https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-linux-arm.tar.gz"
    tarball_path=$(download_with_retry "$tarball_url")

    tar -xzf "$tarball_path" -C /opt
    rm -f "$tarball_path"

    # Run the bundled installer without modifying PATH/rc files
    /opt/google-cloud-sdk/install.sh --quiet --usage-reporting false \
        --path-update false --bash-completion false --command-completion false

    /opt/google-cloud-sdk/bin/gcloud components install anthoscli

    # Create symlinks in /usr/bin
    gcloud_bins=(
        anthoscli
        bq
        docker-credential-gcloud
        gcloud
        gcloud-crc32c
        git-credential-gcloud.sh
        gsutil
    )
    for bin in "${gcloud_bins[@]}"; do
        ln -sf "/opt/google-cloud-sdk/bin/${bin}" "/usr/bin/${bin}"
    done
else
    # Install the Google Cloud CLI via apt
    echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] $REPO_URL cloud-sdk main" > /etc/apt/sources.list.d/google-cloud-sdk.list
    wget -qO- https://packages.cloud.google.com/apt/doc/apt-key.gpg | gpg --dearmor > /usr/share/keyrings/cloud.google.gpg
    apt-get update
    apt-get install google-cloud-cli

    # remove apt
    rm /etc/apt/sources.list.d/google-cloud-sdk.list
    rm /usr/share/keyrings/cloud.google.gpg

    # add repo to the apt-sources.txt
    echo "google-cloud-sdk $REPO_URL" >> $HELPER_SCRIPTS/apt-sources.txt
fi

invoke_tests "CLI.Tools" "Google Cloud CLI"
