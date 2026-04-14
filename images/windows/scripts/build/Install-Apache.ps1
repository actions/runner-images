################################################################################
##  File:  Install-Apache.ps1
##  Desc:  Install Apache HTTP Server
################################################################################

# Stop w3svc service
$w3svcService = Get-Service -Name "w3svc" -ErrorAction SilentlyContinue
if ($w3svcService) {
    Stop-Service $w3svcService
}

# Install latest apache in chocolatey
$installDir = "C:\tools"
Install-ChocoPackage apache-httpd -ArgumentList "--force", "--params", "/installLocation:$installDir /port:80"

# Stop and disable Apache service
Stop-Service -Name Apache
Set-Service -Name Apache -StartupType Disabled

# Start w3svc service
$w3svcService = Get-Service -Name "w3svc" -ErrorAction SilentlyContinue
if ($w3svcService) {
    Start-Service $w3svcService
}

# Invoke Pester Tests
Invoke-PesterTests -TestFile "Apache"
