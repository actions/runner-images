################################################################################
##  File:  Validate-KubernetesCli.ps1
##  Desc:  Validate KubernetesCli.
################################################################################

if (Get-Command -Name 'kubectl')
{
    Write-Host "kubectl $(kubectl version --client=true --short=true) in path"
}
else
{
    Write-Host "kubectl is not in path"
    exit 1
}

if (Get-Command -Name 'minikube')
{
    Write-Host "minikube $(minikube version --short) in path"
}
else
{
    Write-Host "minikube is not in path"
    exit 1
}

