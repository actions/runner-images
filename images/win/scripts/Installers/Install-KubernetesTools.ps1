################################################################################
##  File:  Install-KubernetesTools.ps1
##  Desc:  Install tools for K8s.
################################################################################

Write-Host "Install Kind"
# Choco installation can't be used because it depends on docker-desktop
$url = 'https://api.github.com/repos/kubernetes-sigs/kind/releases/latest'
[System.String] $kindDownloadLink = (Invoke-RestMethod -Uri $url).assets.browser_download_url -match "kind-windows-amd64$"
$destFilePath = "C:\ProgramData\kind"
$null = New-Item -Path $destFilePath -ItemType Directory -Force
Start-DownloadWithRetry -Url $kindDownloadLink -Name "kind.exe" -DownloadPath $destFilePath
Add-MachinePathItem $destFilePath

Write-Host "Install Kubectl"
Choco-Install -PackageName kubernetes-cli

Write-Host "Install Helm"
Choco-Install -PackageName kubernetes-helm

Write-Host "Install Minikube"
Choco-Install -PackageName minikube

Invoke-PesterTests -TestFile "Tools" -TestName "KubernetesTools"