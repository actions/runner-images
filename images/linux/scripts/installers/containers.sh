#!/bin/bash -e
################################################################################
##  File:  containers.sh
##  Desc:  Installs container tools: podman, buildah and skopeo onto the image
################################################################################

# Install podman, buildah, scopeo container's tools
install_packages=(podman buildah skopeo)
source /etc/os-release
sh -c "echo 'deb https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/x${NAME}_${VERSION_ID}/ /' > /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list"
wget -nv https://download.opensuse.org/repositories/devel:kubic:libcontainers:stable/x${NAME}_${VERSION_ID}/Release.key -O Release.key
apt-key add - < Release.key
apt-get update -qq
apt-get -qq -y install ${install_packages[@]}
mkdir -p /etc/containers
echo -e "[registries.search]\nregistries = ['docker.io', 'quay.io']" | tee /etc/containers/registries.conf

# Check that tools are installed properly
echo "Testing to make sure that script performed as expected, and basic scenarios work" 
for cmd in ${install_packages[@]}; do 
    if ! command -v $cmd; then 
        echo "$cmd was not installed" 
        exit 1 
    fi 
done
