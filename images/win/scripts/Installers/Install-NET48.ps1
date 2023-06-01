################################################################################
##  File:  Install-NET48.ps1
##  Desc:  Install .NET 4.8
################################################################################

# .NET 4.8 Dev pack
$InstallerName = "ndp48-x86-x64-allos-enu.exe"
$InstallerUrl = "https://download.visualstudio.microsoft.com/download/pr/2d6bb6b2-226a-4baa-bdec-798822606ff1/8494001c276a4b96804cde7829c04d7f/${InstallerName}"
$ArgumentList = ("Setup", "/passive", "/norestart")

Install-Binary -Url $InstallerUrl -Name $InstallerName -ArgumentList $ArgumentList
