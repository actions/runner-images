################################################################################
##  File:  Install-KubernetesCli.ps1
##  Desc:  Install KubernetesCli
################################################################################

Choco-Install -PackageName kubernetes-cli
Choco-Install -PackageName minikube
minikube start --driver=docker --download-only