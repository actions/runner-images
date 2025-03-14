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


# Install podman, buildah, skopeo container's tools
apt-get update
apt-get install ${install_packages[@]}
mkdir -p /etc/containers
printf "[registries.search]\nregistries = ['docker.io', 'quay.io']\n" | tee /etc/containers/registries.conf

invoke_tests "Tools" "Containers"
