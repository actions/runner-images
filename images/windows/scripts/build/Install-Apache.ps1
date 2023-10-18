################################################################################
##  File:  Install-Apache.ps1
##  Desc:  Install Apache HTTP Server
################################################################################

# Stop w3svc service
Stop-Service -Name w3svc | Out-Null

# Install latest apache in chocolatey
$installDir = "C:\tools"
Choco-Install -PackageName apache-httpd -ArgumentList "--force", "--params", "/installLocation:$installDir /port:80"

# Stop and disable Apache service
Stop-Service -Name Apache
Set-Service Apache -StartupType Disabled

# Start w3svc service
Start-Service -Name w3svc | Out-Null

# Invoke Pester Tests
Invoke-PesterTests -TestFile "Apache"
