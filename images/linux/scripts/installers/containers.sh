#!/bin/bash
################################################################################
##  File:  containers.sh
##  Desc:  Installs container tools: podman, buildah and skopeo onto the image
################################################################################

source $HELPER_SCRIPTS/document.sh

source /etc/os-release
sh -c "echo 'deb http://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/x${NAME}_${VERSION_ID}/ /' > /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list"
wget -nv https://download.opensuse.org/repositories/devel:kubic:libcontainers:stable/x${NAME}_${VERSION_ID}/Release.key -O Release.key
apt-key add - < Release.key
apt-get update -qq
apt-get -qq -y install podman buildah skopeo
mkdir -p /etc/containers
echo -e "[registries.search]\nregistries = ['docker.io', 'quay.io']" | tee /etc/containers/registries.conf

## Add version information to the metadata file
echo "Documenting container tools version"
PODMAN_VERSION="$(podman --version | cut -d " " -f 3)"
BUILDAH_VERSION="$(buildah --version | cut -d " " -f 3)"
SKOPEO_VERSION="$(skopeo --version | cut -d " " -f 3)"
DocumentInstalledItem "Podman ($PODMAN_VERSION)"
DocumentInstalledItem "Buildah ($BUILDAH_VERSION)"
DocumentInstalledItem "Skopeo ($SKOPEO_VERSION)"
