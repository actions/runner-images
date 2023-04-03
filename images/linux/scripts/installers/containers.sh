#!/bin/bash -e
################################################################################
##  File:  containers.sh
##  Desc:  Installs container tools: podman, buildah and skopeo onto the image
################################################################################

source $HELPER_SCRIPTS/os.sh

install_packages=(podman buildah skopeo)

# Packages is available in the official Ubuntu upstream starting from Ubuntu 21
if isUbuntu20; then
    REPO_URL="https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable"
    source /etc/os-release
    sh -c "echo 'deb ${REPO_URL}/x${NAME}_${VERSION_ID}/ /' > /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list"
    wget -qnv https://download.opensuse.org/repositories/devel:kubic:libcontainers:stable/x${NAME}_${VERSION_ID}/Release.key -O Release.key
    apt-key add Release.key
fi

# Install podman, buildah, scopeo container's tools
apt-get update
apt-get -y install ${install_packages[@]}
mkdir -p /etc/containers
echo -e "[registries.search]\nregistries = ['docker.io', 'quay.io']" | tee /etc/containers/registries.conf

if isUbuntu20; then
    # Remove source repo
    rm /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list
    # Document source repo
    echo "containers $REPO_URL" >> $HELPER_SCRIPTS/apt-sources.txt
fi

invoke_tests "Tools" "Containers"
