################################################################################
##  File:  Install-Nginx.ps1
##  Desc:  Install Nginx
################################################################################

# Stop w3svc service
Stop-Service -Name w3svc | Out-Null

# Install latest nginx in chocolatey
$installDir = "C:\tools"
Choco-Install -PackageName nginx -ArgumentList "--force", "--params", "/installLocation:$installDir /port:80"

# Stop and disable Nginx service
Stop-Service -Name nginx
Set-Service nginx -StartupType Disabled

# Start w3svc service
Start-Service -Name w3svc | Out-Null

# Invoke Pester Tests
Invoke-PesterTests -TestFile "Nginx"
