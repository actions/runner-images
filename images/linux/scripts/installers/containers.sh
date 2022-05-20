#!/bin/bash -e
################################################################################
##  File:  containers.sh
##  Desc:  Installs container tools: podman, buildah and skopeo onto the image
################################################################################

install_packages=(podman buildah skopeo)

# Install podman, buildah, scopeo container's tools
apt-get -qq -y install ${install_packages[@]}
mkdir -p /etc/containers
echo -e "[registries.search]\nregistries = ['docker.io', 'quay.io']" | tee /etc/containers/registries.conf

invoke_tests "Tools" "Containers"
