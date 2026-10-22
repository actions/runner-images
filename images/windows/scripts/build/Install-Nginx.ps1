################################################################################
##  File:  Install-Nginx.ps1
##  Desc:  Install Nginx
################################################################################

# Stop w3svc service
$w3svcService = Get-Service -Name "w3svc" -ErrorAction SilentlyContinue
if ($w3svcService) {
    Stop-Service $w3svcService
}

# Install latest nginx in chocolatey
$installDir = "C:\tools"
Install-ChocoPackage nginx -ArgumentList "--force", "--params", "/installLocation:$installDir /port:80"

# Stop and disable Nginx service
Stop-Service -Name nginx
Set-Service -Name nginx -StartupType Disabled

# Start w3svc service
$w3svcService = Get-Service -Name "w3svc" -ErrorAction SilentlyContinue
if ($w3svcService) {
    Start-Service $w3svcService
}

# Invoke Pester Tests
Invoke-PesterTests -TestFile "Nginx"
