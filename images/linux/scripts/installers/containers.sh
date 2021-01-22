#!/bin/bash -e
################################################################################
##  File:  containers.sh
##  Desc:  Installs container tools: podman, buildah and skopeo onto the image
################################################################################

source $HELPER_SCRIPTS/os.sh

# Install podman, buildah, scopeo container's tools
install_packages=(podman buildah skopeo)
source /etc/os-release
sh -c "echo 'deb https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/x${NAME}_${VERSION_ID}/ /' > /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list"
wget -nv https://download.opensuse.org/repositories/devel:kubic:libcontainers:stable/x${NAME}_${VERSION_ID}/Release.key -O Release.key
apt-key add Release.key
apt-get update -qq
apt-get -qq -y install ${install_packages[@]}
mkdir -p /etc/containers
echo -e "[registries.search]\nregistries = ['docker.io', 'quay.io']" | tee /etc/containers/registries.conf

if isUbuntu18 || isUbuntu20 ; then
    invoke_tests "Tools" "Containers"
fi