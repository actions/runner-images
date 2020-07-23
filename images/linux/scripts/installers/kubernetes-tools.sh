#!/bin/bash
################################################################################
##  File:  kubernetes-tools.sh
##  Desc:  Installs kubectl, helm
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh

## Install kubectl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
touch /etc/apt/sources.list.d/kubernetes.list

# Based on https://kubernetes.io/docs/tasks/tools/install-kubectl/, package is xenial for both OS versions.
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list
apt-get update
apt-get install -y kubectl

# Install Helm
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash

# Install minikube
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube


# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
if ! command -v kubectl; then
    echo "kubectl was not installed"
    exit 1
fi

if ! command -v helm; then
    echo "helm was not installed"
    exit 1
fi

# Run tests to determine that the software installed as expected
echo "Testing to make sure that minikube was installed"
if ! command -v minikube; then
    echo "minikube was not installed"
    exit 1
fi

# Document what was added to the image
echo "Lastly, documenting what we added to the metadata file"
DocumentInstalledItem "kubectl ($(kubectl version --client --short |& head -n 1))"
DocumentInstalledItem "helm ($(helm version --short |& head -n 1))"
# minikube version output already has word minikube in it. example minikube version: v1.9.2
DocumentInstalledItem "$(minikube version --short)"