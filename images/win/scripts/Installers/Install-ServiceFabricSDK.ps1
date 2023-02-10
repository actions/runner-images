################################################################################
##  File:  Install-ServiceFabricSDK.ps1
##  Desc:  Install webpicmd and then the service fabric sdk
##         must be install after Visual Studio
################################################################################

# Creating 'Installer' cache folder if it doesn't exist
New-Item -Path 'C:\Windows\Installer' -ItemType Directory -Force

# Get Service Fabric components versions
$serviceFabricRuntimeVersion = (Get-ToolsetContent).serviceFabric.runtime.version
$serviceFabricSDKVersion = (Get-ToolsetContent).serviceFabric.sdk.version

# Install Service Fabric Runtime for Windows
$InstallerName = "MicrosoftServiceFabric.${serviceFabricRuntimeVersion}.exe"
$InstallerUrl = "https://download.microsoft.com/download/b/8/a/b8a2fb98-0ec1-41e5-be98-9d8b5abf7856/${InstallerName}"
$ArgumentList = ("/accepteula ","/quiet","/force")
Install-Binary -Url $InstallerUrl -Name $InstallerName -ArgumentList $ArgumentList

# Install Service Fabric SDK
$InstallerName = "MicrosoftServiceFabricSDK.${serviceFabricSDKVersion}.msi"
$InstallerUrl = "https://download.microsoft.com/download/b/8/a/b8a2fb98-0ec1-41e5-be98-9d8b5abf7856/${InstallerName}"
Install-Binary -Url $InstallerUrl -Name $InstallerName

Invoke-PesterTests -TestFile "Tools" -TestName "ServiceFabricSDK"
