#!/bin/bash -e
################################################################################
##  File:  kubernetes-tools.sh
##  Desc:  Installs kubectl, helm, kustomize
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh

# Install KIND
URL=$(get_github_package_download_url "kubernetes-sigs/kind" "contains(\"kind-linux-amd64\")")
curl -fsSL -o /usr/local/bin/kind $URL
chmod +x /usr/local/bin/kind

## Install kubectl
KUBECTL_VERSION=$(curl -fsSL "https://dl.k8s.io/release/stable.txt")
curl -fsSL -o /usr/local/bin/kubectl "https://dl.k8s.io/release/$KUBECTL_VERSION/bin/linux/amd64/kubectl"
chmod +x /usr/local/bin/kubectl

# Install Helm
curl -fsSL https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash

# Install minikube
curl -fsSL -O https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube

# Install kustomize
download_url="https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"
curl -fsSL "$download_url" | bash
mv kustomize /usr/local/bin

invoke_tests "Tools" "Kubernetes tools"
