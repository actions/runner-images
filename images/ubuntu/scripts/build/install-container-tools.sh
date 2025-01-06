#!/bin/bash -e
################################################################################
##  File:  install-container-tools.sh
##  Desc:  Install container tools: podman, buildah and skopeo onto the image
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/os.sh

#
# pin podman due to https://github.com/actions/runner-images/issues/7753
#                   https://bugs.launchpad.net/ubuntu/+source/libpod/+bug/2024394
#
if ! is_ubuntu22; then
    install_packages=(podman buildah skopeo)
else
    install_packages=(podman=3.4.4+ds1-1ubuntu1 buildah skopeo)
fi

# Packages is available in the official Ubuntu upstream starting from Ubuntu 21
if is_ubuntu20; then
    REPO_URL="https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_$(lsb_release -rs)"
    GPG_KEY="/usr/share/keyrings/devel_kubic_libcontainers_stable.gpg"
    REPO_PATH="/etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list"

    curl -fsSL "${REPO_URL}/Release.key" | gpg --dearmor -o $GPG_KEY
    echo "deb [arch=amd64 signed-by=$GPG_KEY] ${REPO_URL}/ /" > $REPO_PATH
fi

# Install podman, buildah, skopeo container's tools
apt-get update
apt-get install ${install_packages[@]}
mkdir -p /etc/containers
printf "[registries.search]\nregistries = ['docker.io', 'quay.io']\n" | tee /etc/containers/registries.conf

if is_ubuntu20; then
    # Remove source repo
    rm $GPG_KEY
    rm $REPO_PATH

    # Document source repo
    echo "containers $REPO_URL" >> $HELPER_SCRIPTS/apt-sources.txt
fi

invoke_tests "Tools" "Containers"
