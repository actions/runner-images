################################################################################
##  File:  Install-ServiceFabricSDK.ps1
##  Desc:  Install webpicmd and then the service fabric sdk
##         must be install after Visual Studio
##  Supply chain security: checksum validation
################################################################################

# Creating 'Installer' cache folder if it doesn't exist
New-Item -Path 'C:\Windows\Installer' -ItemType Directory -Force

# Get Service Fabric components versions
$runtimeVersion = (Get-ToolsetContent).serviceFabric.runtime.version
$sdkVersion = (Get-ToolsetContent).serviceFabric.sdk.version

$urlBase = "https://download.microsoft.com/download/b/8/a/b8a2fb98-0ec1-41e5-be98-9d8b5abf7856"

# Install Service Fabric Runtime for Windows
Install-Binary `
    -Url "${urlBase}/MicrosoftServiceFabric.${runtimeVersion}.exe" `
    -InstallArgs @("/accepteula ", "/quiet", "/force") `
    -ExpectedSHA256Sum (Get-ToolsetContent).serviceFabric.runtime.checksum


# Install Service Fabric SDK
Install-Binary `
    -Url "${urlBase}/MicrosoftServiceFabricSDK.${sdkVersion}.msi" `
    -ExpectedSHA256Sum (Get-ToolsetContent).serviceFabric.sdk.checksum

Invoke-PesterTests -TestFile "Tools" -TestName "ServiceFabricSDK" 
