#!/bin/bash
################################################################################
##  File:  containercache.sh
##  Desc:  Prepulls Docker images used in build tasks and templates
################################################################################

source $HELPER_SCRIPTS/document.sh

# Check prereqs
echo "Checking prereqs for image pulls"
if ! command -v docker; then
    echo "Docker is not installed, cant pull images"
    exit 1
fi

# Information output
systemctl status docker --no-pager

# Pull images
images=(
    docker.io/jekyll/builder
    mcr.microsoft.com/azure-pipelines/node8-typescript
)

for image in "${images[@]}"; do
    docker pull "$image"
done

## Add container information to the metadata file
 DocumentInstalledItem "Cached container images"

while read -r line; do
    DocumentInstalledItemIndent "$line"
done <<< "$(docker images --digests --format '{{.Repository}}:{{.Tag}} (Digest: {{.Digest}})')"
