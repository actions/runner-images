#!/bin/bash -e
################################################################################
##  File:  kubernetes-tools.sh
##  Desc:  Installs kubectl, helm, kustomize
################################################################################

# Install KIND
URL=$(curl -s https://api.github.com/repos/kubernetes-sigs/kind/releases/latest | jq -r '.assets[].browser_download_url | select(contains("kind-linux-amd64"))')
curl -L -o /usr/local/bin/kind $URL
chmod +x /usr/local/bin/kind

## Install kubectl
KUBECTL_VERSION=$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)
curl -o /usr/local/bin/kubectl -LO https://storage.googleapis.com/kubernetes-release/release/$KUBECTL_VERSION/bin/linux/amd64/kubectl
chmod +x /usr/local/bin/kubectl

# Install Helm
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash

# Install minikube
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube

# Install kustomize
download_url="https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"
curl -s "$download_url" | bash
mv kustomize /usr/local/bin

invoke_tests "Tools" "Kubernetes tools"
