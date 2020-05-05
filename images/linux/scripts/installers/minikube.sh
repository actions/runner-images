#!/bin/bash
################################################################################
##  File:  minikube.sh
##  Desc:  Installs minikube
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh
source $HELPER_SCRIPTS/apt.sh

curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
if ! command -v minikube; then
    echo "minikube not found in path"
    exit 1
fi

# Cache kubernetes images
echo "Caching kubernetes images"
minikube start --driver=docker --download-only

# Document what was added to the image
echo "Lastly, documenting what we added to the metadata file"
DocumentInstalledItem "$(minikube version --short)"
